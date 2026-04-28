
from numba import cuda, float64, int32
import numba    
from src.algos.algo import *

@cuda.jit
def best_ig_dev(categorical_mask_dev, embedded_data_original_dev,index_e_plus, index_e_minus, fst_unused_num,return_vals_dev,pos, neg, unique_vals_present,unique_cats_present,n_cols,used_items=[]):
    
    xp, xn, cp, cn = 0, 0, 0, 0

    bests_sm = cuda.shared.array(shape=32, dtype=float64)
    v_sm = cuda.shared.array(shape=32, dtype=float64)
    r_sm = cuda.shared.array(shape=32, dtype=int32)
    #outer loop is on the columns
    tid = cuda.threadIdx.x
    block_id=cuda.blockIdx.x

    base_block_index=block_id*n_cols
    is_categorical = categorical_mask_dev[block_id] #leva l'offse

    for j in range(tid,n_cols,32):
        pos[base_block_index+j] = 0
        neg[base_block_index+j] = 0
        unique_vals_present[base_block_index+j] = 0
        unique_cats_present[base_block_index+j] = 0

    cuda.syncwarp()
    
    bests_sm[tid]= -1e20
    v_sm[tid] = -1e20
    r_sm[tid] = 0
    num_used = len(used_items)  
    
    #nel codice seriale controllava le cose dentro un for... almeno qua si controllano 1 volta (le colonne sono di un singolo tipo se il dataset è pulito)
    if(is_categorical):

        # --- FASE 1: Processa INDEX_E_PLUS (per cp, xp) ---
        cp = warp_process_sorted_column(
            embedded_data_original_dev, index_e_plus, 
            unique_cats_present, pos, 
            block_id * n_cols, len(index_e_plus), block_id, fst_unused_num[block_id]
        )

        # --- FASE 2: Processa INDEX_E_MINUS (per cn, xn) ---
        cn = warp_process_sorted_column(
            embedded_data_original_dev, index_e_minus, 
            unique_cats_present, neg, 
            block_id * n_cols, len(index_e_minus), block_id, fst_unused_num[block_id]
        )
        cuda.syncwarp()
        num_cats = warp_compact_indices_dev(unique_cats_present, block_id, n_cols)

        for c_i in range(tid, num_cats, 32):
            c=unique_cats_present[base_block_index+c_i]
            skip = 0  # boolean flag
            
            for j in range(num_used):
                if int(used_items[j, 0]) == block_id and int(used_items[j, 1]) in (2,3) and int(used_items[j, 2]) == c:
                    skip = 1
                    break

            if skip:
                continue
            
            c_index=c+base_block_index

            ig = gain_dev(pos[c_index], cp - pos[c_index] + xp, cn - neg[c_index] + xn, neg[c_index])
            
            if bests_sm[tid] < ig:
                bests_sm[tid],  v_sm[tid],  r_sm[tid] = ig, c, 2
            
            ig = gain_dev(cp - pos[c_index] + xp, pos[c_index], neg[c_index], cn - neg[c_index] + xn)

            if bests_sm[tid] < ig:
                bests_sm[tid],  v_sm[tid],  r_sm[tid] = ig, c, 3
                
    else:
        # --- FASE 1: Processa INDEX_E_PLUS (per cp, xp) ---
        xp = warp_process_sorted_column(
            embedded_data_original_dev, index_e_plus, 
            unique_vals_present, pos, 
            block_id * n_cols, len(index_e_plus), block_id, fst_unused_num[block_id]
        )

        # --- FASE 2: Processa INDEX_E_MINUS (per cn, xn) ---
        xn = warp_process_sorted_column(
            embedded_data_original_dev, index_e_minus, 
            unique_vals_present, neg, 
            block_id * n_cols, len(index_e_minus), block_id, fst_unused_num[block_id]
        )

        cuda.syncwarp()
        num_vals = warp_compact_indices_dev(unique_vals_present, block_id, n_cols)

        mask = 0xffffffff
        carry_p = 0.0
        carry_n = 0.0
        off_base = block_id * n_cols
        for chunk_start in range(0, num_vals, 32):
            position_index = chunk_start + tid
            
            # This tells shfl_up_sync exactly which threads are providing data
            active_mask = cuda.ballot_sync(mask, position_index < num_vals)
            
            # 2. Indirect Load 
            if(position_index < num_vals):
            
                # Use a ternary to pick the index; inactive threads just point to base
                load_idx = off_base + unique_vals_present[off_base + position_index] 
                
                p_val = pos[load_idx] 
                n_val = neg[load_idx] 

                # intra-Warp Scan 
                
                shift = 1
                while shift < 32:
                    p_left = cuda.shfl_up_sync(active_mask, p_val, shift)
                    n_left = cuda.shfl_up_sync(active_mask, n_val, shift)
                    if tid >= shift:
                        p_val += p_left
                        n_val += n_left
                    shift *= 2

                # 4. Add the carry from the PREVIOUS chunk
                p_val += carry_p
                n_val += carry_n

                pos[load_idx] = p_val
                neg[load_idx] = n_val

            last_thread_in_chunk = min(31, (num_vals - chunk_start) - 1)
            
            # Broadcast the total sum from that specific last active thread
            carry_p = cuda.shfl_sync(mask, p_val, last_thread_in_chunk)
            carry_n = cuda.shfl_sync(mask, n_val, last_thread_in_chunk)

    
    
    
        for x_i in range(tid, num_vals, 32):
            x=unique_vals_present[base_block_index+x_i]
            skip = 0  # boolean flag
            for j in range(num_used):

                if int(used_items[j, 0]) == block_id and int(used_items[j, 1]) in (0,1) and int(used_items[j, 2]) == x:
                    skip = 1
                    break

            if skip:
                continue
            x_index=base_block_index+x
            ig = gain_dev(pos[x_index], xp - pos[x_index] + cp, xn - neg[x_index] + cn, neg[x_index]) #su gpu, tempi assurdi causa data transfer

            if bests_sm[tid] < ig:
                bests_sm[tid],  v_sm[tid],  r_sm[tid] = ig, x, 0
            
            ig = gain_dev(xp - pos[x_index], pos[x_index] + cp, neg[x_index] + cn, xn - neg[x_index])

            
            if bests_sm[tid] < ig:
                bests_sm[tid],  v_sm[tid],  r_sm[tid] = ig, x, 1
   

    # Sincronizziamo: tutti i thread devono aver finito di marcare unique_...
    cuda.syncwarp()
 
    
    best = bests_sm[tid]
    v    = v_sm[tid]
    r    = r_sm[tid]
    offset = 16
    
    while offset > 0:
        other_best = cuda.shfl_down_sync(mask, best, offset)
        other_v    = cuda.shfl_down_sync(mask, v, offset)
        other_r    = cuda.shfl_down_sync(mask, r, offset)

        if other_best > best or (other_best==best and other_v<v):
            best = other_best
            v = other_v
            r = other_r

        offset //= 2


    if(tid==0):
        return_vals_dev[cuda.blockIdx.x * 3 + 0] = best
        return_vals_dev[cuda.blockIdx.x * 3 + 1] = r
        return_vals_dev[cuda.blockIdx.x * 3 + 2] = v


@cuda.jit(device=True)
def gain_dev(tp, fn, tn, fp):
    # Force double precision
    tp = float(tp)
    fn = float(fn)
    tn = float(tn)
    fp = float(fp)

    if tp + tn < fp + fn:
        result=-1e20
        #print("returning early ")
        return result

    tot_p = tp + fp
    tot_n = tn + fn
    tot = tot_p + tot_n
    ret = 0.0  # float64 by default

    if tp > 0.0:
        ret += tp / tot * math.log(tp / tot_p)
    if fp > 0.0:
        ret += fp / tot * math.log(fp / tot_p)
    if tn > 0.0:
        ret += tn / tot * math.log(tn / tot_n)
    if fn > 0.0:
        ret += fn / tot * math.log(fn / tot_n)
    
    return math.floor(ret / 1e-8) * 1e-8
    
@cuda.jit(device=True)
def warp_compact_indices_dev(unique_vals_present, offset, n_cols):
    tid = cuda.threadIdx.x
    off_base = offset * n_cols
    mask = 0xffffffff
    
    #il num totale di el trovati
    total_found = 0
    
    #chunk da 32
    for chunk_start in range(0, n_cols, 32):
        j = chunk_start + tid
        
        #ogni thread controlla il suo elemento 
        is_present = False
        if j < n_cols:
            is_present = (unique_vals_present[off_base + j] == 1)
        
        ballot = cuda.ballot_sync(mask, is_present)
        
        #l'indice di destinazione LOCALE al chunk e aggiungiamo il totale precedente
        #Quanti '1' ci sono prima di me in QUESTO chunk + quanti ne abbiamo trovati PRIMA
        lower_mask = (1 << tid) - 1
        dest_idx = total_found + cuda.popc(ballot & lower_mask)
        
        
        cuda.syncwarp()
        
        #scrittura (Scatter)
        if is_present:
            unique_vals_present[off_base + dest_idx] = j
            
        total_found += cuda.popc(ballot)
        
        cuda.syncwarp()

    return total_found


@cuda.jit(device=True)
def warp_reduce_sum_dev(val):
    #Sum across all threads in a warp
    mask = 0xffffffff
    for offset in (16, 8, 4, 2, 1):
        val += cuda.shfl_down_sync(mask, val, offset)
    return cuda.shfl_sync(mask, val, 0)

@cuda.jit(device=True)
def warp_process_sorted_column(original_data, index_list,
                               uniques, counts_hist,
                               off_base, len_indices, col_idx,
                               unused_val):
    tid = cuda.threadIdx.x

    global_count = 0
    # Process in warp-sized chunks
    for chunk_start in range(0, len_indices, 32):
        mask = 0xffffffff
        pos_in_list = chunk_start + tid
        active = pos_in_list < len_indices
        active_mask = cuda.ballot_sync(mask, active)

        # Load value or placeholder
        d = -1
        if active:
            idx = index_list[pos_in_list]
            d = original_data[idx, col_idx]
        else:
            d=unused_val
            
        if active:
            same_mask = cuda.match_any_sync(active_mask, d)
            count = cuda.popc(same_mask)
            mask_before = same_mask & ((1 << tid) - 1)

            # First thread has no bits set before it
            is_first = mask_before == 0
            if(is_first):
                uniques[off_base + d] = 1
                global_count += count
                counts_hist[off_base + d] += count #pos/neg
        cuda.syncwarp()

    return warp_reduce_sum_dev(global_count)
