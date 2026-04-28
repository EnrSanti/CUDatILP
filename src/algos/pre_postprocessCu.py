import numpy as np
from timeit import default_timer as timer


####################################### PREPROCESSING ##########################################

#From the dataset (matrix) return a matrix of the same size with only integer values and a dictionary provinding a mapping (and reverse mapping) between the two matrices

def embed_data_global(data):
    timer_t = timer()

    categorical_cols = []
    

    # Detect categorical columns
    for col in range(len(data[0])):
        val = data[0][col]
        if isinstance(val, str):
            categorical_cols.append(col)

    # Collect all unique values across all categorical columns
    data_np = np.array(data)
     
    
    # Encode the data
    timer2 = timer()
    print(f"Time for global embedding 1: {timer2 - timer_t:.4f}s")
    encoded_data,placeholder_numeric, rev_map,range_per_col = encode_data_global_with_placeholder(data_np, categorical_cols)
    rev_map[-1]=rev_map[len(data[0])-1]
    timer3 = timer()
    print(f"Time for global embedding 2: {timer3 - timer2:.4f}s")
    return encoded_data, categorical_cols, placeholder_numeric, rev_map,range_per_col

def encode_data_global_with_placeholder(data_np, categorical_cols):
    n_rows, n_cols = data_np.shape
    encoded = np.empty((n_rows, n_cols), dtype=np.int64)

    rev_map = {}
    max_values_array = {}

    placeholder_numeric = [0]*n_cols
    range_per_col=[0]*n_cols

    numeric_cols = [col for col in range(n_cols) if col not in categorical_cols]

    # ---------------------------
    # NUMERIC COLUMNS
    # ---------------------------
    for col in numeric_cols:


        col_data = data_np[:, col].astype(np.float64)

        # C-speed unique + inverse mapping
        uniques, inv = np.unique(col_data, return_inverse=True)

        encoded[:, col] = inv

        rev_map[col] = uniques
        range_per_col[col] = len(uniques)

        # placeholder = max index + 1
        placeholder_numeric[col] = len(uniques)

        max_values_array[col] = len(uniques) - 1

    # ---------------------------
    # CATEGORICAL COLUMNS
    # ---------------------------
    for col in categorical_cols:
        col_data = data_np[:, col]

        # string/object safe encoding
        uniques, inv = np.unique(col_data, return_inverse=True)
        rev_map[col] = uniques
        encoded[:, col] = inv

        # build mapping only once (for interpretability)
       
        range_per_col[col] = len(uniques)

        placeholder_numeric[col] = len(uniques)

        max_values_array[col] = len(uniques) - 1

    return encoded, placeholder_numeric, rev_map, range_per_col

#######################################                ##########################################
####################################### POSTPROCESSING ##########################################

#From the learned rules in the hypotesis i translate back the int values back to strings and floats

def remap_to_cat_rule(obj, categorical_cols, reverse_map):
    
    #print("ramapping on obj" + str(obj))
    # Case 1: literal (INT, OP, VALUE)
    VALID_OPS=[0,1,2,3] # <= > == !=
    MAPPED_OPS=['<=','>','==','!=']
    if (
        isinstance(obj, tuple)
        and len(obj) == 3
        and isinstance(obj[0], int)
        and isinstance(obj[1], int)
        and obj[1] in VALID_OPS
    ):
        col, op, val = obj
        #print("base canse \n")
        val = reverse_map[col][val]
        
        m_op=MAPPED_OPS[op]
        return (col, m_op, val)

    # Case 2: tuple (general)
    if isinstance(obj, tuple):
        #print("TUPLE calling it on \n", [x for x in obj])
        return tuple(
            remap_to_cat_rule(x, categorical_cols, reverse_map)
            for x in obj
        )

    # Case 3: list
    if isinstance(obj, list):
        
        #print("TUPLE calling it on \n", [x for x in obj])
        return [
            remap_to_cat_rule(x, categorical_cols, reverse_map)
            for x in obj
        ]

    # Case 4: anything else
    return obj

