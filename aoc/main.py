import subprocess
import time
import os
import pandas as pd
from tqdm.auto import tqdm
import psutil
import platform
import pytz
import datetime

def get_platform_name():
    # Using psutil
    physical_cores = psutil.cpu_count(logical=False)
    cpu_freq = psutil.cpu_freq()

    # Using platform
    processor_name = platform.processor()
    architecture = platform.architecture()[0]

    return f"{processor_name} ({architecture}, {physical_cores} CPUs) {cpu_freq.current} MHz"

def get_local_time():
    
    # Get the local timezone
    local_timezone = datetime.datetime.now().astimezone().tzinfo
    
    # Get the current time in the local timezone
    current_time_local = datetime.datetime.now(local_timezone)

    return current_time_local, local_timezone

# Function to measure execution time of a single run
def measure_exec_time(command):
    start_time = time.time()
    process = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    end_time = time.time()
    return end_time - start_time, process.stdout.decode('utf-8'), process.stderr.decode('utf-8')

def update_task(day=None, task=None, num_runs=100):
    # parse args
    if day is None:
        day_list = range(1, 26)
    else:
        day_list = [int(day)]

    if task is None:
        task_list = ["a", "b"]
    else:
        task_list = [str(task)]

    # Dictionary to store the results
    results = {}
    for name in ["theo", "damso", "julo"]:
        for language in ["cpp", "ocaml"]:
            name_language = f"{name} ({language})"
            for day in day_list:
                for task in task_list:
                    if (name_language, day, task) not in results:
                        exec_path = f"../build/{language}/day{day:02}/{name}/{task}"
                        if os.path.exists(exec_path):
                            # Measure execution times
                            times = []
                            for _ in tqdm(range(num_runs), desc=f"{name_language}: {day}{task}"):
                                exec_time, stdout, stderr = measure_exec_time(exec_path)
                                times.append(exec_time)
                                if stderr:
                                    print(f"Error running {exec_path}: {stderr}")
        
                            # Store the results in the dictionary
                            results[(name_language, day, task)] = times
                    else:
                        pass
                        # no need to compute again

    df_results = pd.DataFrame(results)
    return df_results

if __name__ == "__main__":
    # Formatting helper
    platform_name = get_platform_name()
    current_time_local, local_timezone = get_local_time()

    # Run compiled code
    num_runs = 1000
    df_results = update_task(day=None, task=None, num_runs=num_runs)
    df_results_avg = df_results.apply(lambda col: pd.Series({
        "mean": col.mean(), "std": col.std(ddof=1), "sample": len(col)
    }))
    df_results_avg.to_csv(f"../output/{platform_name}_{num_runs}_raw.csv")
    df_results_avg_formatted = df_results_avg.loc["mean"].unstack(0).applymap(lambda x: f"{1000*x:.1f} ms")
    df_results_avg_formatted.index = pd.MultiIndex.from_tuples(df_results_avg_formatted.index).set_names(["day", "task"])
    df_results_avg_formatted = df_results_avg_formatted.reset_index()
    df_results_avg_md = df_results_avg_formatted.to_markdown(index=False)

    print(f"Results of {num_runs} iterations from {platform_name}, updated {current_time_local} ({local_timezone})")
    print(df_results_avg_md)