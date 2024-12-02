# AldosAdventOfCode2024

Repo to store the compiled AoC24 codes of Aldo's members and compare the execution times.

# Source files

- [theo](https://github.com/tirelt/AdventOfCode/tree/master/2024)

## Leaderboard

in ms
| day | theo | damso | julo |
:------:|:-----|:----:|:-----:|
|1|0.4|0.3||
|2|0.2|||
|3||||
|4||||
|5||||
|6||||
|7||||
|8||||
|9||||
|10||||
|11||||
|12||||
|13||||
|14||||
|15||||
|16||||
|17||||
|18||||
|19||||
|20||||
|21||||
|22||||
|23||||
|24||||
|25||||

## How does it work

### C++

First, we move inside the `cpp` folder
```bash
cd cpp
```

Let us compile the file of `julo` for day 1, for the second task (b)
```bash
bash main.sh compile julo 1 b
```

We want to run them now:
```bash
bash main.sh run julo 1 b
```

### Measure time 

We use python to measure the time, display the performances and print the updated table.

First, we need our virtual environment:
```bash
python -m venv aoc_venv
source aoc_venv/bin/activate
pip install -r requirements.txt
```

Then run the code
```bash
source aoc_venv/bin/activate
cd aoc
python main.py
```
And copy the output below


# Results

Results of 1000 iterations from i386 (64bit, 2 CPUs) 2300 MHz, updated 2024-12-02 20:50:02.451991+08:00 (HKT)
|   day | task   | julo (cpp)   | theo (cpp)   |
|------:|:-------|:-------------|:-------------|
|     1 | a      | 25.8 ms      | 28.6 ms      |
|     1 | b      | 27.2 ms      | 29.9 ms      |

# TODO
- [ ] Automatic compiling when the c++ source exists but not the built file
- [ ] main.sh for ocaml files
- [ ] add source files from Damien