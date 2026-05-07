
from numba import cuda, float64, int32
import numba
from src.algos.algo import *

@cuda.jit(device=True)
def evaluate_dev(items, dataset_example, categorical_cols):
    n_items = items.shape[0]
    if n_items == 0:
        return 0

    for idx in range(n_items):
        i = int(items[idx, 0])
        r = items[idx, 1]
        v = items[idx, 2]

        val = dataset_example[i]
        is_categorical = False
        for c_idx in range(len(categorical_cols)):
            if categorical_cols[c_idx] == i:
                is_categorical = True
                break

        if is_categorical:
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

    return 1

#molto temporanamente solo con due blocchi, con più blocchi servono 2 lanci di kernel diversi
@cuda.jit
def update_e_plus_min_dev(index_sizes,items, embedded_data_original, categorical_cols,index_pos,len_index_pos,index_neg,len_index_neg):
    #molto temporanamente solo con due blocchi, con più blocchi servono 2 lanci di kernel diversi    
    tid = cuda.threadIdx.x
    block_id = cuda.blockIdx.x
    total_found = 0
    if(block_id==0):
        for chunk_start in range(0, len_index_pos, 32):
            pos_in_list = chunk_start + tid
            mask = 0xffffffff
            active = pos_in_list < len_index_pos
            active_mask = cuda.ballot_sync(mask, active)
            # Load value or placeholder
            remove = -1
            i=-1
            if active:
                remove=0
                i=index_pos[pos_in_list]
                covered=evaluate_dev(items,embedded_data_original[i],categorical_cols)
                if(not covered):
                    remove=1
            ballot = cuda.ballot_sync(active_mask, remove==0)
            lower_mask = (1 << tid) - 1
            dest_idx = total_found + cuda.popc(ballot & lower_mask)
            cuda.syncwarp()

            if(remove==0): #keep
                index_pos[dest_idx]=i
            total_found += cuda.popc(ballot)
            cuda.syncwarp()
    else:
        for chunk_start in range(0, len_index_neg, 32):
            pos_in_list = chunk_start + tid
            mask = 0xffffffff
            active = pos_in_list < len_index_neg
            active_mask = cuda.ballot_sync(mask, active)
            # Load value or placeholder
            remove = -1
            i=-1
            if active:
                remove=0
                i=index_neg[pos_in_list]
                covered=evaluate_dev(items,embedded_data_original[i],categorical_cols)
                if(not covered):
                    remove=1
            ballot = cuda.ballot_sync(active_mask, remove==0)
            lower_mask = (1 << tid) - 1
            dest_idx = total_found + cuda.popc(ballot & lower_mask)
            cuda.syncwarp()

            if(remove==0): #keep
                index_neg[dest_idx]=i
            total_found += cuda.popc(ballot)
            cuda.syncwarp()
    if(tid==0):
        index_sizes[block_id]=total_found



#molto temporanamente solo con due blocchi, con più blocchi servono 2 lanci di kernel diversi
@cuda.jit
def update_tn_tp(index_sizes,nodes_dev, literals_dev, embedded_data_original, categorical_cols,index_pos,len_index_pos,index_neg,len_index_neg):
    #molto temporanamente solo con due blocchi, con più blocchi servono 2 lanci di kernel diversi    
    tid = cuda.threadIdx.x
    block_id = cuda.blockIdx.x
    total_found = 0
    if(block_id==0): #plus
        print(len_index_pos)

        for chunk_start in range(0, len_index_pos, 32):
            pos_in_list = chunk_start + tid
            mask = 0xffffffff
            active = pos_in_list < len_index_pos
            #which threads didn't pass the index len
            active_mask = cuda.ballot_sync(mask, active)
            # Load value or placeholder
            remove = -1
            i=-1
            if active:
                remove=0
                i=index_pos[pos_in_list]
                covered=evaluate_dev_full_rule(nodes_dev, literals_dev, embedded_data_original[i],categorical_cols,i, 1)
                print("th. ",tid, " checking el. ", i, " covered ",int(covered))
                if(covered):
                    remove=1
            ballot = cuda.ballot_sync(active_mask, remove==0) #conto quelli da tenere
            #print("ballot to keep", ballot)
            lower_mask = (1 << tid) - 1
            dest_idx = total_found + cuda.popc(ballot & lower_mask)
            cuda.syncwarp()

            if(remove==0): #keep
                index_pos[dest_idx]=i
                #print("keep the positive el in ",i, "th", tid)
            total_found += cuda.popc(ballot)
            cuda.syncwarp()
            break #REMOVE
    else:
        for chunk_start in range(0, len_index_neg, 32):
            pos_in_list = chunk_start + tid
            mask = 0xffffffff
            active = pos_in_list < len_index_neg
            active_mask = cuda.ballot_sync(mask, active)
            # Load value or placeholder
            remove = -1
            i=-1
            if active:
                remove=0
                i=index_neg[pos_in_list]
                covered=evaluate_dev_full_rule(nodes_dev, literals_dev, embedded_data_original[i],categorical_cols,i,0)
                if(covered):
                    remove=1
            ballot = cuda.ballot_sync(active_mask, remove==0)
            lower_mask = (1 << tid) - 1
            dest_idx = total_found + cuda.popc(ballot & lower_mask)
            cuda.syncwarp()

            if(remove==0): #keep
                index_neg[dest_idx]=i
            total_found += cuda.popc(ballot)
            cuda.syncwarp()
    if(tid==0):
        index_sizes[block_id]=total_found

@cuda.jit(device=True)
def evaluate_dev_full_rule(nodes, literals, dataset_example, categorical_cols, example_no,flag):
    N = len(literals)

    #empty rule
    if(N == 0):
        return False
    
    
    nodes_no=len(nodes)

    #for all the nodes
    for el in range(nodes_no):
        
        #peek
        node_start,node_len,lv=nodes[el]

        desired_val=lv%2
        
        cond=True
        overall_cond=True
        if(desired_val==0):
            desired_val=1
        else:
            desired_val=0



        #positive part of rule
        for el in range (node_start, node_start+node_len):
            #evaluate positive vals
            i,r,v=literals[el]
            if(flag==1):
                print("th:", cuda.threadIdx.x,
                    "desired_val:", desired_val,
                    "node", i, r, v, "[",dataset_example[0],dataset_example[1],dataset_example[2],dataset_example[3],dataset_example[4],dataset_example[5],dataset_example[6],"], example no: ",example_no)
            
            val = dataset_example[i]
                    
            is_categorical = False
            for c_idx in range(len(categorical_cols)):
                if categorical_cols[c_idx] == i:
                    is_categorical = True
                    break

            if is_categorical:
                if r == 2:
                    cond = val == v
                    if(flag==1):
                        print("th:", cuda.threadIdx.x,"case cat comapring col ",i, " == ", val, v, "resulting: ",int(cond), "[",dataset_example[0],dataset_example[1],dataset_example[2],dataset_example[3],dataset_example[4],dataset_example[5],dataset_example[6],"]")
                elif r == 3:
                    cond = val != v
                    if(flag==1):
                        print("th:", cuda.threadIdx.x,"case cat comapring col ",i, " != ", val, v, "resulting: ",int(cond), "[",dataset_example[0],dataset_example[1],dataset_example[2],dataset_example[3],dataset_example[4],dataset_example[5],dataset_example[6],"]")
            else:
                if r == 0:
                    cond = val <= v
                    if(flag==1):
                        print("th:", cuda.threadIdx.x,"case num comapring col ",i, " <= ", val, v, "resulting: ",int(cond), "[",dataset_example[0],dataset_example[1],dataset_example[2],dataset_example[3],dataset_example[4],dataset_example[5],dataset_example[6],"]")
                elif r == 1:
                    cond = val > v
                    if(flag==1):
                        print("th:", cuda.threadIdx.x,"case num comapring col ",i, " > ", val, v, "resulting: ",int(cond), "[",dataset_example[0],dataset_example[1],dataset_example[2],dataset_example[3],dataset_example[4],dataset_example[5],dataset_example[6],"]")
            
           
            overall_cond=overall_cond and cond
        
        #-------------------------
        if(desired_val==1):
            if(overall_cond==False):
                print("th:", cuda.threadIdx.x,"returning FALSE for subrule", "[",dataset_example[0],dataset_example[1],dataset_example[2],dataset_example[3],dataset_example[4],dataset_example[5],dataset_example[6],"]")
                return False
        else:
            if(overall_cond==True):
                print("th:", cuda.threadIdx.x,"returning FALSE for subrule", "[",dataset_example[0],dataset_example[1],dataset_example[2],dataset_example[3],dataset_example[4],dataset_example[5],dataset_example[6],"]")
                return False
    if(flag==1):
        print("th:", cuda.threadIdx.x,"returning true", "[",dataset_example[0],dataset_example[1],dataset_example[2],dataset_example[3],dataset_example[4],dataset_example[5],dataset_example[6],"]")
    return True

@cuda.jit
def print_dev(index_e_plus_dev,size_plus):
    for i in range(size_plus):
        print("in eplus index -> ", index_e_plus_dev[i])