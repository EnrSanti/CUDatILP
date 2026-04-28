
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
def update_tn_tp(index_sizes,normal_dev,nodes_dev, literals_dev, edges_dev, embedded_data_original, categorical_cols,index_pos,len_index_pos,index_neg,len_index_neg):
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
                covered=evaluate_dev_full_rule(normal_dev,nodes_dev, literals_dev, edges_dev,embedded_data_original[i],categorical_cols)
                if(covered):
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
                covered=evaluate_dev_full_rule(normal_dev,nodes_dev, literals_dev, edges_dev,embedded_data_original[i],categorical_cols)
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
def evaluate_dev_full_rule(normal,nodes, literals, edges, dataset_example, categorical_cols):

    print("normal gpu normal", normal)
    if cuda.threadIdx.x == 0 and cuda.blockIdx.x == 0:
        print("NORMAL:")
        for i in range(1):
            print(int(normal[0, 0]), int(normal[0, 1]), int(normal[0, 2]))
        #normal part of main rule
    n_items = normal.shape[0]
    if n_items > 0:
        for idx in range(n_items):
            i = int(normal[idx, 0])
            r = normal[idx, 1]
            v = normal[idx, 2]

            val = dataset_example[i]
            is_categorical = False #con una mask è meglio ma vabbè per ora ok
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
    
    N = len(nodes)

    node_vals = cuda.local.array(128, numba.int32)
    stack = cuda.local.array(128, numba.int32)

    sp = 0
    stack[sp] = 0   # root
    sp += 1

    #while i have nodes in the stack
    while sp > 0:
        #pop
        node = stack[sp - 1]

        #if already managed ok
        if node_vals[node] != -1:
            sp -= 1
            continue
        
        has_children = 0
        all_ready = 1
        or_val = 0

        #get the children
        for e in range(len(edges)):
            p, c = edges[e]

            if p == node:
                has_children = 1
                if node_vals[c] == -1:
                    #push
                    stack[sp] = c
                    sp += 1
                    all_ready = 0
                else:
                    # se ho già valutato il figlio c.
                    if node_vals[c] == 1:
                        or_val = 1

        if not all_ready: #i figli hanno figli, tocca valutare prima quelli
            continue
        
        start = nodes[node][0]
        length = nodes[node][1]

        val = 1

        for j in range(length):
            i, r, v = literals[start + j]
            x = dataset_example[i]

            cond = 0
            
            for c_idx in range(len(categorical_cols)):
                if categorical_cols[c_idx] == i:
                    is_categorical = True
                    break

            if is_categorical:
                if r == 2:
                    cond = (x == v)
                elif r == 3:
                    cond = (x != v)
            else:
                if r == 0:
                    cond = (x <= v)
                elif r == 1:
                    cond = (x > v)

            if not cond:
                val = 0
                break

        # --- combine ---
        if has_children:
            val = val and or_val

        node_vals[node] = val
        sp -= 1

    return node_vals[0]