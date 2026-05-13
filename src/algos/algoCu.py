import math
from numba import cuda, float64, int32
import numpy as np
from timeit import default_timer as timer
from src.algos.algo import *
from src.algos.pre_postprocessCu import *
from src.algos.best_ig_kernelsCu import *
from src.algos.cover_kernelsCu import *
from src.common.flatRule import *
import cupy as cp

#######################################                ##########################################
#######################################  MAIN METHODS  ##########################################

def CUDatILP(data, ratio=0.5):
    ret = []
    # Accumulators for timings
    overall_most = 0
    overall_split = 0
    overall_learn = 0
    overall_covers1 = 0
    overall_setop = 0
    total_loops = 0
    overall_best_item=0
    overall_covers=0 
    overall_fold = 0 
    total_time = 0 
    learn_rule_loops = 0
    
    
    begin_preprocess = timer()
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

    end_preprocess = timer()
    overall_preprocess = end_preprocess - begin_preprocess


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
    post_time=0
    while len(original_data_indexes) > 0:
        total_loops += 1

        start_most = timer()
        l = most_(embedded_data_original, original_data_indexes) #CPU

        #print(l)
        end_most = timer()
        overall_most += end_most - start_most
        
        start_split = timer()

        #invece degli elementi prendo gli indici
        index_e_plus, index_e_minus = split_data_by_item_(embedded_data_original, l,categorical_cols, original_data_indexes) #CPU but indexes
 
        #move
        #index_e_plus_gpu  = cp.asarray(index_e_plus)
        #index_e_minus_gpu = cp.asarray(index_e_minus)
        
        end_split = timer()
        overall_split += end_split - start_split

        start_learn = timer()
        items_np,items_dev, rule,best_item, coversTime,foldTime,timeTotal,loops = learn_rule_(embedded_data_original,index_e_plus, index_e_minus , categorical_cols,categorical_cols_dev,categorical_mask_dev, fst_unused_num_dev, max_range_cols,embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev, index_sizes_dev ,[], ratio)

        overall_best_item+=best_item
        overall_covers+=coversTime
        overall_fold+=foldTime
        total_time+=timeTotal
        learn_rule_loops+=loops
        end_learn = timer()
        overall_learn += end_learn - start_learn
        
        start_covers1 = timer()
        start_setop = timer()
        if(len(index_e_plus)+len(index_e_minus)>5000): #true for now, just to check
            
            e_tp_index_dev  = cuda.to_device(np.array(index_e_plus, dtype=np.int32))
            e_tn_index_dev = cuda.to_device(np.array(index_e_minus, dtype=np.int32))
            
            #print("THE INDEX BEFORE index_e_plus: ", index_e_plus)
            #print("size: ",len(index_e_plus))
            #print("original index e_plus: ", len(index_e_plus))
            #print("original index e_minus: ", len(index_e_plus))
            #e_tp_index = [i for i in index_e_plus if not cover_(rule, embedded_data_original, i,categorical_cols,0)]
            #e_tn_index =  [i for i in index_e_minus if not cover_(rule, embedded_data_original, i,categorical_cols,1)]
            
            #print("SERIAL plus to keep: ", len(e_tp_index))
            #print("-minus to keep: ", len(e_tn_index))
            #print(rule)
            flatRule = FlatState.from_root(rule)
            #print("rule: ",rule)                            
            #print("flatRule: ",flatRule)
            n_valid_tp,n_valid_tn=cover_on_gpu_full_rule(flatRule, embedded_data_original_dev, categorical_cols_dev,e_tp_index_dev,e_tn_index_dev,len(index_e_plus),len(index_e_minus), index_sizes_dev)
            
            #print("valid tp:",n_valid_tp)

            # 2. Taglia l'array direttamente sulla GPU (lo slicing in Numba non copia dati)
            # e POI copia solo la parte utile sull'host
            if(n_valid_tp>0):
                e_tp_index = e_tp_index_dev[:n_valid_tp].copy_to_host().tolist()
            else:
                e_tp_index=[]
            if(n_valid_tn>0):
                e_tn_index = e_tn_index_dev[:n_valid_tn].copy_to_host().tolist()
            else:
                e_tn_index=[]

            #print("loop: ",debug_loops, "\n tp_index: ",e_tp_index,"\n tn_index: ",e_tn_index)

            if len(e_tp_index) == len(index_e_plus):
                break
            #print("after GPU e_tp_index: ", e_tp_index)
            original_data_indexes = e_tp_index + e_tn_index

        else:
            e_tp_index = [i for i in index_e_plus if not cover_(rule, embedded_data_original, i,categorical_cols)]

            end_covers1 = timer()
            overall_covers1 += end_covers1 - start_covers1

            if len(e_tp_index) == len(index_e_plus):
                break

            e_tn_index =  [i for i in index_e_minus if not cover_(rule, embedded_data_original, i,categorical_cols)]
            original_data_indexes = e_tp_index + e_tn_index


        #print("----------\n")
        #print("remaining original data indexes "+str(original_data_indexes))
        #print("remaining embedded_data "+str(embedded_data))
        
        
         
        end_setop = timer()

        overall_setop += end_setop - start_setop
        
        # Append rule with selected literal
        #print("to print -> " + str(rule_to_print))
        rule = l, rule[1], rule[2], rule[3]
        
        begin_post = timer()
        rule=remap_to_cat_rule((rule), categorical_cols, rev_map)
        end_post = timer()
        post_time = end_post - begin_post + post_time
        ret.append(rule)
        
        #print("rule -> "+str(rule))

    # Total time spent
    #print("all rules")
    #print(ret)
    total_time = overall_most + overall_split + overall_learn + overall_covers1 + overall_setop

    print(f"Timing summary after {total_loops} loops:")
    print(f"most:        {overall_most:.4f}s ({100 * overall_most/total_time:.1f}%)")
    print(f"split_data:  {overall_split:.4f}s ({100 * overall_split/total_time:.1f}%)")
    print(f"learn_rule:  {overall_learn:.4f}s ({100 * overall_learn/total_time:.1f}%)")
    
    print(f"----learn_rule summary after {learn_rule_loops} loops:")
    print(f"----best_item: {overall_best_item:.4f}s ({100 * overall_best_item/total_time:.1f}%)")
    print(f"----cover:     {overall_covers:.4f}s ({100 * overall_covers/total_time:.1f}%)")
    print(f"----fold:      {overall_fold:.4f}s ({100 * overall_fold/total_time:.1f}%)")


    print(f"cover check: {overall_covers1:.4f}s ({100 * overall_covers1/total_time:.1f}%)")
    print(f"set op:      {overall_setop:.4f}s ({100 * overall_setop/total_time:.1f}%)")
    print(f"Total:       {total_time:.4f}s")

    print(f"Time preprocessing: {overall_preprocess:.4f}s")
    
    print(f"Time postprocessing: {post_time:.4f}s")
    return ret


def cover_(rule, embedded_data_original, i,categorical_cols,flag=0):
    example_x=embedded_data_original[i]
    
    return evaluate_(rule, example_x, categorical_cols,flag,0)

def cover_on_gpu(items_dev, embedded_data_original_dev, categorical_cols_dev,index_e_plus_dev,index_e_minus_dev,size_plus,size_minus,index_sizes_dev):
    
    #SI, TEMPORANEAMENTE SOLO CON 2 BLOCCHI, con più blocchi servono 2 kernel diversi lanciati uno dopo l'altro
    update_e_plus_min_dev[2,32](index_sizes_dev,items_dev, embedded_data_original_dev, categorical_cols_dev,index_e_plus_dev,size_plus,index_e_minus_dev,size_minus)
    host_counts = index_sizes_dev.copy_to_host()

    size_plus = int(host_counts[0])
    size_minus = int(host_counts[1])
    return size_plus,size_minus

def cover_on_gpu_full_rule(rule, embedded_data_original_dev, categorical_cols_dev,index_e_plus_dev,index_e_minus_dev,size_plus,size_minus,index_sizes_dev):
    
    #SI, TEMPORANEAMENTE SOLO CON 2 BLOCCHI, con più blocchi servono 2 kernel diversi lanciati uno dopo l'altro
    #print("rule to on gpu: ", rule)
    nodes = np.asarray(rule.nodes, dtype=np.int32)
    literals = np.asarray(rule.literals, dtype=np.int32)
    edges = np.asarray(rule.edges, dtype=np.int32).reshape(-1, 2)

    nodes_dev = cuda.to_device(nodes)
    literals_dev = cuda.to_device(literals)
    edges_dev = cuda.to_device(edges)

    #print_dev[1,1](index_e_plus_dev,size_plus)
    update_tn_tp[2,32](index_sizes_dev,nodes_dev, literals_dev, edges_dev, embedded_data_original_dev, categorical_cols_dev,index_e_plus_dev,size_plus,index_e_minus_dev,size_minus)
    host_counts = index_sizes_dev.copy_to_host()

    size_plus = int(host_counts[0])
    size_minus = int(host_counts[1])
    #print("plus to keep: ", size_plus)
    #print("-minus to keep: ", size_minus)
    return size_plus,size_minus

def evaluate_(item, dataset_example, categorical_cols,flag=0,that=0):

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

                

    # Negative literals (any must NOT hold)
    if len(item[2]) > 0:
        for sub in item[2]:
            
            if evaluate_(sub, dataset_example, categorical_cols,flag,that): 
                
                
                return False
          
    return 1


def learn_rule_(embedded_data_original,  index_e_plus,       index_e_minus,                categorical_cols, categorical_cols_dev,categorical_mask, fst_unused_num_dev,max_range_cols,embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev,index_sizes_dev ,used_items=[], ratio=0.5):
    items = []
    items_3array=[]
    learn_rule_loops = 0

    # Timing accumulators
    overall_best_item = 0
    overall_covers = 0
    overall_fold = 0
    while True:
        learn_rule_loops += 1

        # ===== best_item timing =====
        start_best_item = timer()
        
        if len(index_e_plus) != 0 or len(index_e_minus) != 0:
            index_e_plus_dev  = cuda.to_device(np.array(index_e_plus, dtype=np.int32))
            index_e_minus_dev = cuda.to_device(np.array(index_e_minus, dtype=np.int32))

        t,t_arr = best_item_gpu(index_e_plus_dev,index_e_minus_dev, embedded_data_original, index_e_plus, index_e_minus, categorical_mask, fst_unused_num_dev,max_range_cols, embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev ,used_items + items)

        end_best_item = timer()
        overall_best_item += end_best_item - start_best_item 

        items.append(t)
        items_3array.append(t_arr)
        items_np = np.array(items_3array, dtype=np.float64)
        items_dev = cuda.to_device(items_np)
        rule = -1, items, [], 0
        # ===== cover timing =====
        start_cover_pos_neg = timer()
        #gets rows

        

        if(len(index_e_plus)+len(index_e_minus)>5000): #remove
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
        

        end_cover_pos_neg = timer()
        overall_covers += end_cover_pos_neg - start_cover_pos_neg

        # Check termination conditions
        if t[0] == -1 or len(index_e_minus) <= len(index_e_plus) * ratio:
            if t[0] == -1:
                rule = -1, items[:-1], [], 0

            if len(index_e_minus) > 0 and t[0] != -1:
                # ===== fold timing =====
                start_fold = timer()
                ab = fold_gpu(embedded_data_original,index_e_minus,index_e_plus ,categorical_cols,categorical_cols_dev,categorical_mask,fst_unused_num_dev,max_range_cols, embedded_data_original_dev, neg_dev, pos_dev, vals_dev, cats_dev ,index_sizes_dev,used_items + items,  ratio)
                end_fold = timer()
                overall_fold += end_fold - start_fold
                if len(ab) > 0:
                    rule = rule[0], rule[1], ab, 0
            break

    # Total time for profiling
    total_time = overall_best_item + overall_covers + overall_fold
    return items_np,items_dev, rule, overall_best_item, overall_covers,overall_fold,total_time,learn_rule_loops

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
        _,_,rule,_,_,_,_,_ = learn_rule_(embedded_data_original,index_e_plus, index_e_minus, categorical_cols,categorical_cols_dev, categorical_mask,placeholder_nums_dev,max_range_cols,embedded_data_original_dev,neg_dev, pos_dev, vals_dev, cats_dev ,index_sizes_dev,used_items, ratio)
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
        if evaluate_(l, x,categorical_cols,0):
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