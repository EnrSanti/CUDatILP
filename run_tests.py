from src.common.foldrm import *
from src.common.datasets import *
from timeit import default_timer as timer
from datetime import timedelta
import re
import threading
import matplotlib.pyplot as plt
import numpy as np
from datetime import datetime
import os

def run_test_split(test_func,name,ratio):
    model,data_train, data_test = test_func()  #c.a. 6 min e 30 a 0.2 di ratio
    
    start = timer()
    model.fit(data_train, ratio=ratio)
    end = timer()

    h_cpu=model.get_asp(simple=True)

    Y = [d[-1] for d in data_test]
    Y_test_hat = model.predict(data_test)
    accuracy_cpu = get_scores(Y_test_hat, data_test)
    print('% acc', round(accuracy_cpu, 4), '# rules', len(model.crs))
    acc, p, r, f1 = scores(Y_test_hat, Y, weighted=True)
    print('% acc', round(acc, 4), 'macro p r f1', round(p, 4), round(r, 4), round(f1, 4), '# rules', len(model.crs))



    del(model)
    del(data_train)
    del(data_test)

    model,data_train, data_test = test_func()  #c.a. 6 min e 30 a 0.2 di ratio

    start_gpu = timer()
    model.fitGPU(data_train,bg_file=None, col_names=model.attrs, ratio=ratio)
    end_gpu = timer()


    h_gpu=model.get_asp(simple=True)
    Y = [d[-1] for d in data_test]
    Y_test_hat = model.predict(data_test)
    accuracy_gpu = get_scores(Y_test_hat, data_test)
    print('% acc', round(accuracy_gpu, 4), '# rules', len(model.crs))
    acc, p, r, f1 = scores(Y_test_hat, Y, weighted=True)
    print('% acc', round(acc, 4), 'macro p r f1', round(p, 4), round(r, 4), round(f1, 4), '# rules', len(model.crs))

    print("----------------------------------------------------------------")

    RED = "\033[91m"
    GREEN = "\033[92m"
    RESET = "\033[0m"
    YELLOW = "\033[33m"
    if h_cpu != h_gpu:
        print(h_cpu)
        print("-----")
        print(h_gpu)
        if(accuracy_cpu == accuracy_gpu):
            print(f"{YELLOW}OK WORKS, != hyp = accuracy{RESET}")
            print(f"Serial: {timedelta(seconds=end - start)} Parallel: {timedelta(seconds=end_gpu - start_gpu)}")
            time_serial=end - start
            time_parallel=end_gpu - start_gpu
            return 0,time_serial,time_parallel,name
        else:
            print(f"{RED}test1 failed{RESET}")
            return 1,-1,-1,name
    else:
        print(f"{GREEN}test passed{RESET}")
        print(f"Serial: {timedelta(seconds=end - start)} Parallel: {timedelta(seconds=end_gpu - start_gpu)}")

        time_serial=end - start
        time_parallel=end_gpu - start_gpu
        return 0,time_serial,time_parallel, name
    
def run_test_to_split_ds(test_func,name, ratio,ds_ratio):
    model, data = test_func() #11 sec a 0.5 o 10 min & 30 a 0.2 di ratio

    data_train, data_test = split_data_deterministically(data, ratio=ds_ratio)


    #sposta dati su gpu

    start = timer()
    model.fit(data_train, ratio=ratio)
    end = timer()

    h_cpu=model.get_asp(simple=True)
    Y = [d[-1] for d in data_test]
    Y_test_hat = model.predict(data_test)
    accuracy_cpu = get_scores(Y_test_hat, data_test)
    print('% acc', round(accuracy_cpu, 4), '# rules', len(model.crs))
    acc, p, r, f1 = scores(Y_test_hat, Y, weighted=True)
    print('% acc', round(acc, 4), 'macro p r f1', round(p, 4), round(r, 4), round(f1, 4), '# rules', len(model.crs))



    del(model)
    del(data)
    del(data_train)
    del(data_test)


    model, data = test_func() #11 sec a 0.5 o 10 min & 30 a 0.2 di ratio

    data_train, data_test = split_data_deterministically(data, ratio=ds_ratio)

    start_gpu = timer()

    model.fitGPU(data_train,bg_file=None, col_names=model.attrs,ratio=ratio)
    end_gpu = timer()

    h_gpu=model.get_asp(simple=True)
    Y = [d[-1] for d in data_test]
    Y_test_hat = model.predict(data_test)
    accuracy_gpu = get_scores(Y_test_hat, data_test)
    print('% acc', round(accuracy_gpu, 4), '# rules', len(model.crs))
    acc, p, r, f1 = scores(Y_test_hat, Y, weighted=True)
    print('% acc', round(acc, 4), 'macro p r f1', round(p, 4), round(r, 4), round(f1, 4), '# rules', len(model.crs))

    print("----------------------------------------------------------------")
    RED = "\033[91m"
    GREEN = "\033[92m"
    RESET = "\033[0m"
    YELLOW = "\033[33m"
    if h_cpu != h_gpu:
        print(h_cpu)
        print("-----")
        print(h_gpu)
        if(accuracy_cpu == accuracy_gpu):
            print(f"{YELLOW}OK WORKS, != hyp = accuracy{RESET}")
            print(f"Serial: {timedelta(seconds=end - start)} Parallel: {timedelta(seconds=end_gpu - start_gpu)}")
            time_serial=end - start
            time_parallel=end_gpu - start_gpu
            return 0,time_serial,time_parallel, name
        else:
            print(f"{RED}test failed{RESET}")
            print("ACCURACIES ", accuracy_cpu, " vs ", accuracy_gpu)
            return 1,-1,-1, name
    else:
        print(f"{GREEN}test passed{RESET}")
        print(f"Serial: {timedelta(seconds=end - start)} Parallel: {timedelta(seconds=end_gpu - start_gpu)}")

        time_serial=end - start
        time_parallel=end_gpu - start_gpu
        return 0,time_serial,time_parallel, name

datasets_split = {
    "MNIST": (MNIST,"MNIST",0.5)}
datasets_to_split = {
    "jannis": (jannis,"jannis",0.8,0.2),
    "MiniBooNE": (MiniBooNE,"MiniBooNE",0.8,0.2),
    "human_activity": (human_activity,"human_activity",0.9,0.3),
    "lifestyle": (lifestyle,"lifestyle",0.8,0.2),
    "sloan": (sloan,"sloan",0.9,0.3),
    "diabetes": (diabetes,"diabetes",0.8,0.25),
    "smoke_drink": (smoke_drink,"smoke_drink",0.7,0.4),
    "covertype": (coverType,"covertype",0.8,0.2),
    "crops": (crops,"crops",0.8,0.3),
    "nepal_earthquake": (nepal_earthquake,"nepal_earthquake",0.7,0.3),
    "weather": (weather,"weather",0.8,0.25)
    }


def compare_times():

    benchmark_tasks = []

    

    # --- split datasets ---
    for name, (fn, pretty_name, ds_ratio, fit_ratio) in datasets_to_split.items():
        benchmark_tasks.append(
            (run_test_to_split_ds, fn, pretty_name, fit_ratio,ds_ratio)
        )

    # --- no split datasets ---
    for name, (fn, pretty_name, ratio) in datasets_split.items():
        benchmark_tasks.append(
            (run_test_split, fn, pretty_name, ratio, None)
        )


    


    n_runs = 5
    errors = 0

    serial_times_all = [[] for _ in benchmark_tasks]
    parallel_times_all = [[] for _ in benchmark_tasks]
    names = [""] * len(benchmark_tasks)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    all_filename = f"benchmark_all_{timestamp}.txt"

    with open(all_filename, "w") as f:
        f.write("Test,Run,Name,SerialTime,ParallelTime,Speedup\n")

        for idx, task in enumerate(benchmark_tasks):
            runner = task[0]
            fn = task[1]
            name = task[2]
            ratio1 = task[3]
            ratio2 = task[4]

            try:
                for run_idx in range(n_runs):
                    print(f"[Test {name}] Run {run_idx+1}")

                    # ---- dispatch correctly ----
                    if ratio2 is None:
                        result_flag, t_ser, t_par, name = runner(fn, name, ratio1)
                    else:
                        result_flag, t_ser, t_par, name = runner(fn, name, ratio1, ratio2)

                    names[idx] = name

                    if result_flag:
                        errors += 1
                        serial_times_all[idx].append(None)
                        parallel_times_all[idx].append(None)
                        f.write(f"{name},{run_idx+1},ERROR,ERROR,ERROR\n")
                    else:
                        serial_times_all[idx].append(t_ser)
                        parallel_times_all[idx].append(t_par)

                        speedup = t_ser / t_par if t_par else None
                        f.write(f"{name},{run_idx+1},{name},{t_ser},{t_par},{speedup}\n")

            except Exception as e:
                import traceback
                print(f"[Test {name}] crashed:", e)
                print(traceback.format_exc())
                errors += 1

    # ---------- stats ----------
    def mean_ignore_none(lst):
        valid = [x for x in lst if x is not None]
        return sum(valid) / len(valid) if valid else None

    avg_serial = [mean_ignore_none(x) for x in serial_times_all]
    avg_parallel = [mean_ignore_none(x) for x in parallel_times_all]

    avg_speedup = [
        (s / p if s is not None and p is not None else None)
        for s, p in zip(avg_serial, avg_parallel)
    ]

    long_idx = [i for i, t in enumerate(avg_serial) if t and t > 300]
    short_idx = [i for i, t in enumerate(avg_serial) if t and t <= 300]
    print(avg_serial)
    print(avg_parallel)
    print(avg_speedup)
    print("long : ",long_idx)
    print("short : ",short_idx)
    def save_and_plot(group_idx, group_name):
        if not group_idx:
            print(f"No {group_name} tests to plot.")
            return

        fname = f"benchmark_{group_name}_{timestamp}.txt"

        with open(fname, "w") as f:
            f.write("Test,AvgSerial,AvgParallel,AvgSpeedup\n")
            for i in group_idx:
                f.write(f"{names[i]},{avg_serial[i]},{avg_parallel[i]},{avg_speedup[i]}\n")


    save_and_plot(long_idx, "long")
    save_and_plot(short_idx, "short")

    if errors == 0:
        print("\033[92mALL TESTS PASSED\033[0m")
    else:
        print(f"\033[91m{errors} TESTS FAILED\033[0m")

    print(f"All raw results saved to {all_filename}")

    

def main():
    
    compare_times()

if __name__ == '__main__':
    main()