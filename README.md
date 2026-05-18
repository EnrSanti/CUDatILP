# CUD@ILP

This is CUDA parallel version of the FOLD-RM algorithm which is built for binary classification tasks. FOLD-R++ (https://github.com/hwd404/FOLD-RM) learns default rules that are represented as an [answer set program](https://en.wikipedia.org/wiki/Answer_set_programming) which is a [logic program](https://en.wikipedia.org/wiki/Logic_programming) that include [negation of predicates](https://en.wikipedia.org/wiki/Negation) and follow the [stable model semantics](https://en.wikipedia.org/wiki/Stable_model_semantics) for interpretation. [Default logic](https://en.wikipedia.org/wiki/Default_logic) (with exceptions) closely models human thinking.

-----------
## Use it as you would normally use FOLD

## This branch:
- Aims to improve the speedups of the main one while trying to add the notion of background rules in the ILP task.


## How to test:

- Run_tests.py -> launches (absolutely rudimental) the training on the selected tests both on the default serial version (model.fit) and on CUDA (model.fitGPU), compares the times and the final hypothesis obtained (they must be equal since the datasets are NOW slpit into train and test statically and not randomly).

