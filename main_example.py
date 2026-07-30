from src.common.foldrm import *
from src.common.datasets import *
from timeit import default_timer as timer
from datetime import timedelta


def main_with_bg(): #with bg and LLM 
    model, data = iris()

    data_train, data_test = split_data_deterministically(data, ratio=0.75)

    start = timer()
    model.fitGPU(data_train, bg_file="results/interpretability_results/experiments/iris/iris_bg.lp", col_names=model.attrs, ratio=0.6)
    end = timer()

    model.print_asp(simple=True)
    Y = [d[-1] for d in data_test]
    Y_test_hat = model.predict(data_test)
    acc = get_scores(Y_test_hat, data_test)
    print('% acc', round(acc, 4), '# rules', len(model.crs))
    acc, p, r, f1 = scores(Y_test_hat, Y, weighted=True)

    print('% acc', round(acc, 4), 'macro p r f1', round(p, 4), round(r, 4), round(f1, 4), '# rules', len(model.crs))

    print('% cudatilp costs: ', timedelta(seconds=end - start), '\n')

    model.set_translator(OllamaTranslator(model="cudatilp")) # name of the model created via Modelfile

    problem_description = "This is one of the earliest datasets used in the literature on classification methods and widely used in statistics and machine learning.  The data set contains 3 classes of 50 instances each, where each class refers to a type of iris plant.  One class is linearly separable from the other 2; the latter are not linearly separable from each other."
    print("% Natural language summary of the learned rules... \n")
    print(model.summary(description=problem_description, ), "\n")


def main_without_bg():
    model, data = iris()

    data_train, data_test = split_data_deterministically(data, ratio=0.75)

    start = timer()
    model.fitGPU(data_train, bg_file=None, col_names=model.attrs, ratio=0.6)
    end = timer()

    model.print_asp(simple=True)
    Y = [d[-1] for d in data_test]
    Y_test_hat = model.predict(data_test)
    acc = get_scores(Y_test_hat, data_test)
    print('% acc', round(acc, 4), '# rules', len(model.crs))
    acc, p, r, f1 = scores(Y_test_hat, Y, weighted=True)

    print('% acc', round(acc, 4), 'macro p r f1', round(p, 4), round(r, 4), round(f1, 4), '# rules', len(model.crs))

    #AS FOLD-RM, but faster

if __name__ == '__main__':
    main_with_bg()
    #main_without_bg()