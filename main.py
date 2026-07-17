from src.common.foldrm import *
from src.common.datasets import *
from timeit import default_timer as timer
from datetime import timedelta


def main():
    model, data = satellite()

    data_train, data_test = split_data(data, ratio=0.8)

    start = timer()
    model.fitGPU(data_train, bg_file="data/bg_sat.lp", col_names=model.attrs, ratio=0.5)
    end = timer()

    model.print_asp(simple=True)
    Y = [d[-1] for d in data_test]
    Y_test_hat = model.predict(data_test)
    acc = get_scores(Y_test_hat, data_test)
    print('% acc', round(acc, 4), '# rules', len(model.crs))
    acc, p, r, f1 = scores(Y_test_hat, Y, weighted=True)

    print('% acc', round(acc, 4), 'macro p r f1', round(p, 4), round(r, 4), round(f1, 4), '# rules', len(model.crs))

    print('% foldrm costs: ', timedelta(seconds=end - start), '\n')

    model.set_translator(OllamaTranslator(model="foldrm-qwen"))

    problem_description = "This is a satellite classification problem where we want to classify satellites based on their features."
    print("% Natural language summary of the learned rules... \n")
    print(model.summary(description=problem_description, ), "\n")

if __name__ == '__main__':
    main()