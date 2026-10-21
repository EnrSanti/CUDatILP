import math
from numba import cuda, float64, int32
import numpy as np
from timeit import default_timer as timer
from src.algos.algo import *
from src.algos.pre_postprocessCu import *
from src.algos.best_ig_kernelsCu import *
from src.algos.cover_kernelsCu import *
import cupy as cp

#######################################                ##########################################
#######################################  MAIN METHODS  ##########################################

def CUDatILP(data, ratio=0.5):
    ret = []

    embedded_data,categorical_cols,fst_unused_num, rev_map,max_range_cols=embed_data_global(data)
    
    #print(mapping) col & str -> int (0,1.. n)
    #i just need to keep track of the size of mapping (n) and a list of strings
    #reverse_map = {v: k for k, v in mapping.items()}


    minus_1_col=len(data[0])-1
    
    if(minus_1_col in categorical_cols):
        categorical_cols.append(-1)
        categorical_cols.remove(minus_1_col)

    # Initialize an array of zeros
    categorical_mask = np.zeros(len(data[0]), dtype=int)

    # Set the specified indices to 1
    categorical_mask[categorical_cols] = 1
    categorical_mask_dev = cuda.to_device(np.array(categorical_mask, dtype=np.int32))
    
    

    #print("categorical cols"+str(categorical_cols))
    #print("last col"+str(minus_1_col))

    
    cp.cuda.Stream.null.synchronize()

    #orignal_training_data=data
    original_data_indexes = list(range(len(data)))
    embedded_data_original=embedded_data
    embedded_data_original_dev = cuda.to_device(
        np.array(embedded_data_original, dtype=np.int32)  # or np.int32 if ints
    )

    categorical_cols_dev = cuda.to_device(np.array(categorical_cols, dtype=np.int32))
    fst_unused_num_dev = cuda.to_device(np.array(fst_unused_num, dtype=np.int32))

    num_blocks=len(embedded_data_original[0])-1
    
    neg_dev = cuda.device_array(max(max_range_cols)*num_blocks, dtype=np.int32)
    pos_dev = cuda.device_array(max(max_range_cols)*num_blocks, dtype=np.int32)
    vals_dev = cuda.device_array(max(max_range_cols)*num_blocks, dtype=np.int32)
    cats_dev = cuda.device_array(max(max_range_cols)*num_blocks, dtype=np.int32)
    index_sizes_dev = cuda.device_array(2, dtype=np.int32) #e+ e-

    while len(original_data_indexes) > 0:
      

        l = most_(embedded_data_original, original_data_indexes) #CPU


        #invece degli elementi prendo gli indici
        index_e_plus, index_e_minus = split_data_by_item_(embedded_data_original, l,categorical_cols, original_data_indexes) #CPU but indexes
 
        #move
        #index_e_plus_gpu  = cp.asarray(index_e_plus)
        #index_e_minus_gpu = cp.asarray(index_e_minus)
        
        rule = learn_rule_(embedded_data_original,index_e_plus, index_e_minus , categorical_cols,categorical_cols_dev,categorical_mask_dev, fst_unused_num_dev, max_range_cols,embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev, index_sizes_dev ,[], ratio)

       
        
        e_tp_index = [i for i in index_e_plus if not cover_(rule, embedded_data_original, i,categorical_cols)]
        
        if len(e_tp_index) == len(index_e_plus):
            break

        
        e_tn_index =  [i for i in index_e_minus if not cover_(rule, embedded_data_original, i,categorical_cols)]
        
        original_data_indexes = e_tp_index + e_tn_index

        
        # Append rule with selected literal
        rule = l, rule[1], rule[2], rule[3]
        
        rule=remap_to_cat_rule((rule), categorical_cols, rev_map)
        ret.append(rule)
        

    return ret


def cover_(rule, embedded_data_original, i,categorical_cols):
    example_x=embedded_data_original[i]
    return evaluate_(rule, example_x, categorical_cols)

def cover_on_gpu(items_dev, embedded_data_original_dev, categorical_cols_dev,index_e_plus_dev,index_e_minus_dev,size_plus,size_minus,index_sizes_dev):
    
    #SI, TEMPORANEAMENTE SOLO CON 2 BLOCCHI, con più blocchi servono 2 kernel diversi lanciati uno dopo l'altro
    update_e_plus_min_dev[2,32](index_sizes_dev,items_dev, embedded_data_original_dev, categorical_cols_dev,index_e_plus_dev,size_plus,index_e_minus_dev,size_minus)
    host_counts = index_sizes_dev.copy_to_host()

    size_plus = int(host_counts[0])
    size_minus = int(host_counts[1])
    return size_plus,size_minus


def evaluate_(item, dataset_example, categorical_cols):

    if len(item) == 0:
        return 0  # automatically false

    # -------------------------
    # Simple literal case
    # -------------------------
    if len(item) == 3:
        i, r, v = item
        val = dataset_example[i]

        if i in categorical_cols:
            if r == 2:
                return val == v
            elif r == 3:
                return val != v
            else:
                return False
        else:
            if r == 0:
                return val <= v
            elif r == 1:
                return val > v
            else:
                return False

    # -------------------------
    # Complex rule case
    # -------------------------
    # item structure assumed:
    # [?, positive_literals, negative_literals, flag]

    # If flag == 0 → conjunction must hold
    if item[3] == 0 and len(item[1]) > 0:
        for sub in item[1]:
            if len(sub) == 3:
                i, r, v = sub
                val = dataset_example[i]

                if i in categorical_cols:
                    if r == 2:
                        cond = val == v
                    elif r == 3:
                        cond = val != v
                    else:
                        cond = False

                else:
                    if r == 0:
                        cond = val <= v
                    elif r == 1:
                        cond = val > v
                    else:
                        cond = False

              
                if not cond:
                    return 0

            else:
                if not evaluate_(sub, dataset_example, categorical_cols):
                    return 0

    # Negative literals (any must NOT hold)
    if len(item[2]) > 0:
        for sub in item[2]:
            if len(sub) == 3:
                i, r, v = sub
                val = dataset_example[i]

                if i in categorical_cols:
                    if r == 2:
                        cond = val == v
                    elif r == 3:
                        cond = val != v
                    else:
                        cond = False

                else:
                    if r == 0:
                        cond = val <= v
                    elif r == 1:
                        cond = val > v
                    else:
                        cond = False


                if cond:
                    return 0

            else:
                if evaluate_(sub, dataset_example, categorical_cols):
                    return 0
    return 1


def learn_rule_(embedded_data_original,  index_e_plus,       index_e_minus,                categorical_cols, categorical_cols_dev,categorical_mask, fst_unused_num_dev,max_range_cols,embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev,index_sizes_dev ,used_items=[], ratio=0.5):
    items = []
    items_3array=[]

    while True:

        if len(index_e_plus) != 0 or len(index_e_minus) != 0:
            index_e_plus_dev  = cuda.to_device(np.array(index_e_plus, dtype=np.int32))
            index_e_minus_dev = cuda.to_device(np.array(index_e_minus, dtype=np.int32))

        t,t_arr = best_item_gpu(index_e_plus_dev,index_e_minus_dev, embedded_data_original, index_e_plus, index_e_minus, categorical_mask, fst_unused_num_dev,max_range_cols, embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev ,used_items + items)

       
        items.append(t)
        items_3array.append(t_arr)
        items_np = np.array(items_3array, dtype=np.float64)
        items_dev = cuda.to_device(items_np)
        rule = -1, items, [], 0
        

        

        if(len(index_e_plus)+len(index_e_minus)>5000):
            n_valid_plus,n_valid_minus=cover_on_gpu(items_dev, embedded_data_original_dev, categorical_cols_dev,index_e_plus_dev,index_e_minus_dev,len(index_e_plus),len(index_e_minus), index_sizes_dev)
            

            # 2. Taglia l'array direttamente sulla GPU (lo slicing in Numba non copia dati)
            # e POI copia solo la parte utile sull'host
            if(n_valid_plus>0):
                index_e_plus = index_e_plus_dev[:n_valid_plus].copy_to_host().tolist()
            else:
                index_e_plus=[]
            if(n_valid_minus>0):
                index_e_minus = index_e_minus_dev[:n_valid_minus].copy_to_host().tolist()
            else:
                index_e_minus=[]
        else:
            index_e_plus = [i for i in index_e_plus if cover_(rule, embedded_data_original, i,categorical_cols)]
            index_e_minus = [i for i in index_e_minus  if cover_(rule, embedded_data_original, i,categorical_cols)]
        

        # Check termination conditions
        if t[0] == -1 or len(index_e_minus) <= len(index_e_plus) * ratio:
            if t[0] == -1:
                rule = -1, items[:-1], [], 0

            if len(index_e_minus) > 0 and t[0] != -1:
                # ===== fold timing =====
                ab = fold_gpu(embedded_data_original,index_e_minus,index_e_plus ,categorical_cols,categorical_cols_dev,categorical_mask,fst_unused_num_dev,max_range_cols, embedded_data_original_dev, neg_dev, pos_dev, vals_dev, cats_dev ,index_sizes_dev,used_items + items,  ratio)
                
                if len(ab) > 0:
                    rule = rule[0], rule[1], ab, 0
            break

    # Total time for profiling
    return rule

def best_item_gpu(index_e_plus_dev,index_e_minus_dev,embedded_data_original,index_e_plus, index_e_minus,categorical_mask_dev, fst_unused_num_dev,max_range_cols, embedded_data_original_dev, pos_dev,neg_dev, vals_dev,cats_dev , used_items=[]):

    ret = -1, 0, 0
    ret_arr = [-1, 0, 0]
    if len(index_e_plus) == 0 and len(index_e_minus) == 0:
        return ret,ret_arr
    
    n = len(embedded_data_original[index_e_plus[0]]) if len(index_e_plus) > 0 else len(embedded_data_original[index_e_minus[0]]) #prende la lunghezza di una riga
    best = cp.float32(-1e20)

    

    #max_range_cols_dev   = cuda.to_device(np.array(max_range_cols, dtype=np.int32))

    # 4) Numeric placeholders -> float32 array

    n_max=max(max_range_cols)
    used_items_arr = np.zeros((len(used_items), 3), dtype=cp.float64)

    for j, (col, cmp, val) in enumerate(used_items):
        used_items_arr[j, 0] = col       # column index as float32 (or int32 if you like)
        used_items_arr[j, 1] = cmp       # comparator as float32 (or int32)
        used_items_arr[j, 2] = val       # value (float)

    used_items_dev = cuda.to_device(used_items_arr)

    thread_per_block=32
    blocks_grid=n-1
    
    return_vals_dev = cuda.device_array(3*(n-1), dtype=cp.float64)


    
    #blocchi piccoli ma è tutto intrawarp con molte colonne già scala, con poche tocca aumentare il numero di blocchi o lanciare con + th
    best_ig_dev[blocks_grid,thread_per_block](categorical_mask_dev,  embedded_data_original_dev,index_e_plus_dev, index_e_minus_dev,fst_unused_num_dev, return_vals_dev, pos_dev, neg_dev, vals_dev,cats_dev,n_max,used_items_dev)
        
        
        
        
    cuda.synchronize()

    #print("ig1 on host: ",host_arr[0], "ig2 on host: ", host_arr[1])
    return_vals_host = return_vals_dev.copy_to_host()  # returns a NumPy array
    n_triplets = len(return_vals_host) // 3

    for i in range(n_triplets):
        idx = i * 3
        ig = return_vals_host[idx]
        r  = return_vals_host[idx + 1]
        v  = return_vals_host[idx + 2]
        
        v=int(v) if v != -1e20 else v
        r=int(r)
        if best < ig:
            best = ig
            ret = i, r, v
            ret_arr = [i,r,v]
    return ret , ret_arr

def fold_gpu(embedded_data_original, index_e_plus, index_e_minus, categorical_cols,categorical_cols_dev,categorical_mask,placeholder_nums_dev, max_range_cols,embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev ,index_sizes_dev,used_items=[], ratio=0.5):
    ret = []
    while len(index_e_plus) > 0:
        rule = learn_rule_(embedded_data_original,index_e_plus, index_e_minus, categorical_cols,categorical_cols_dev, categorical_mask,placeholder_nums_dev,max_range_cols,embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev ,index_sizes_dev,used_items, ratio)
        data_fn = [i for i in index_e_plus if not cover_(rule, embedded_data_original,i, categorical_cols)]
        if len(index_e_plus) == len(data_fn):
            break
        index_e_plus = data_fn
        ret.append(rule)
    return ret


                #fixed size (can be >>) #non fixed size (int arrays) #int  #fixed size array #fixed size array #non fixed size array

def split_data_by_item_(embedded_data, l,categorical_cols, original_data_indexes):
    data_pos, data_neg = [], []

    for i in original_data_indexes:
        x=embedded_data[i]
        if evaluate_(l, x,categorical_cols):
            data_pos.append(i) #lui aggiungeva righe io aggiungo INDICI DELLE COLLONE IN sorted_T
        else:
            data_neg.append(i)
    return data_pos, data_neg


def most_(data, original_data_indexes, i=-1):
    tab = dict()
    
    for row_index in original_data_indexes:
        d=data[row_index]
        if d[i] not in tab:
            tab[d[i]] = 0
        tab[d[i]] += 1
    
    y, n = 0, 0
    for t in tab:
        if n <= tab[t]:
            y, n = t, tab[t]
    return i, 2, y