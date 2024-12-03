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

### Ocaml

First, we move inside the `ocaml` folder

```bash
cd ocaml
```

Install opam if necessary with brew.

Then init opam

```bash
opam init
```

Select `Option 5: No, I'll remember to run eval $(opam env) when I need opam`.

Finally instal packages

```bash
opam install base
opam install core
opam install stdio
```

<!-- eval $(opam env) -->

Let us compile the file of `damso` for day 1, for the second task (b)

```bash
bash main.sh compile damso 1 b
```

We want to run them now:

```bash
bash main.sh run damso 1 b
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

Results of 1000 iterations from i386 (64bit, 2 CPUs) 2300 MHz, updated 2024-12-03 22:24:28.522258+08:00 (HKT)
| day | task | damso (ocaml) | julo (cpp) | theo (cpp) |
|------:|:-------|:----------------|:-------------|:-------------|
| 1 | a | 48.6 ms | 24.9 ms | 26.5 ms |
| 1 | b | 144.5 ms | 26.8 ms | 28.1 ms |
| 2 | a | 45.5 ms | nan ms | nan ms |
| 2 | b | 47.0 ms | nan ms | 31.9 ms |
| 3 | a | 81.0 ms | nan ms | 29.1 ms |
| 3 | b | 68.5 ms | nan ms | 30.2 ms |

# TODO

- [x] Theo's 2b is not compiling
- [ ] Automatic compiling when the c++/ocaml source exists but not the built file
- [x] main.sh for ocaml files
- [x] add source files from Damien
- [ ] don't measure everything again every day, only new added tasks
- [ ] use https://github.com/sharkdp/hyperfine instead of naive python time measure
- [ ] solve day 2 to 3
