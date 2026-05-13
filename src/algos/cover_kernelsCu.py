
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
def update_tn_tp(index_sizes,nodes_dev, literals_dev,edges_dev, embedded_data_original, categorical_cols,index_pos,len_index_pos,index_neg,len_index_neg):
    #molto temporanamente solo con due blocchi, con più blocchi servono 2 lanci di kernel diversi    
    tid = cuda.threadIdx.x
    block_id = cuda.blockIdx.x
    total_found = 0
    if(block_id==0): #plus

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
                covered=evaluate_dev_full_rule(nodes_dev, literals_dev,edges_dev, embedded_data_original[i],categorical_cols,i, 0)
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
            #break #REMOVE
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
                covered=evaluate_dev_full_rule(nodes_dev, literals_dev,edges_dev, embedded_data_original[i],categorical_cols,i,1)
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
def evaluate_dev_full_rule(nodes, literals,edges, dataset_example, categorical_cols, example_no,flag):

    N = len(literals)

    #empty rule
    if(N == 0):
        return False
    
    stack_evals = cuda.local.array(128, dtype=int32)  

    nodes_no=len(nodes)
    if(nodes_no>128):
        print("ISSUE WITH THE NUMBER OF NODES! ")

    #start from ending noeds which are single parts
    for node_idx in range(len(nodes) - 1, -1, -1):
        _, node_start, node_len = nodes[node_idx]
        cond=True
        falsified_by_children=False

        for edge in range(edges.shape[0]):
            #print("checking children")
            if edges[edge,0] == node_idx:
                child_index = edges[edge,1]
                child_val=stack_evals[child_index]
                falsified_by_children |= child_val

                
        for el in range (node_start, node_start+node_len):
                
            #evaluate positive vals
            i,r,v=literals[el]
            
            #falsified_by_children TRUE <=> all children are true or NO CHILDREN
            
            
            if(not falsified_by_children): #i eval only if children didn't already falsified me 
                #if(flag==1):
                #    print("th:", cuda.threadIdx.x,"col ",i, "falsified_by_children: ", falsified_by_children)
                val = dataset_example[i]
                        
                is_categorical = False
                for c_idx in range(len(categorical_cols)):
                    if categorical_cols[c_idx] == i:
                        is_categorical = True
                        break
                
                if is_categorical:
                    if r == 2:
                        cond &= val == v
                    elif r == 3:
                        cond &= val != v
                else:
                    if r == 0:
                        cond &= val <= v
                    elif r == 1:
                        cond &= val > v
            else:
                cond=False

            
            stack_evals[node_idx]=cond #eval node
   
    return stack_evals[0]
  

@cuda.jit
def print_dev(index_e_plus_dev,size_plus):
    for i in range(size_plus):
        print("in eplus index -> ", index_e_plus_dev[i])