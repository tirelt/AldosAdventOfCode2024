# AldosAdventOfCode2024

Repo to store the compiled AoC24 codes of Aldo's members and compare the execution times.
(prerequisites and usage secrtion below)

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

Results of 1000 iterations from arm (64bit, 10 CPUs) 4 MHz, updated 2024-12-04 23:04:28.815850+08:00 (HKT)
|   day | task   | damso (ocaml)   | julo (cpp)   | theo (cpp)   |
|------:|:-------|:----------------|:-------------|:-------------|
|     1 | a      | 14.0 ms         | 7.6 ms       | 7.7 ms       |
|     1 | b      | 26.2 ms         | 7.5 ms       | 8.2 ms       |
|     2 | a      | 12.9 ms         | nan ms       | 8.5 ms       |
|     2 | b      | 13.3 ms         | nan ms       | 8.5 ms       |
|     3 | a      | 57.2 ms         | nan ms       | 7.8 ms       |
|     3 | b      | 46.0 ms         | nan ms       | 7.8 ms       |
|     4 | a      | nan ms          | nan ms       | 7.2 ms       |
|     4 | b      | nan ms          | nan ms       | 7.1 ms       |
|     5 | a      | nan ms          | nan ms       | 25.9 ms       |
|     5 | b      | nan ms          | nan ms       | 25.5 ms       |
|     6 | a      | nan ms          | nan ms       | 32.9 ms       |
|     6 | b      | nan ms          | nan ms       | 5101.1 ms       |
|     7 | a      | nan ms          | nan ms       | 17.6 ms        |
|     7 | b      | nan ms          | nan ms       | 168.3 ms       |
|     8 | a      | nan ms          | nan ms       | 7.8 ms       |
|     8 | b      | nan ms          | nan ms       | 7.8 ms       |

# Prerequisites 

## Install OCaml

Install opam if necessary with brew (`brew install opam`).

Then init opam:

```bash
opam init
```
<!-- eval $(opam env) -->

Select `Option 5: No, I'll remember to run eval $(opam env) when I need opam`.

Finally install the packages

```bash
opam install base
opam install core
opam install stdio
```

## Check C++ install

On most unix master race machines `g++` is installed by default. To check the version:
```bash
g++ --version
```
That's all you need to compile/run C++ scripts.

## Install python venv

We use python to measure the time, display the performances and print the updated table.

We need to build our virtual environment:

```bash
python -m venv aoc_venv #or python3 or the path to your python.exe
source aoc_venv/bin/activate
pip install -r requirements.txt
```
## Make the script executable 

The `.sh` files need to be executable
```bash
chmod +x [name_script]
```
# Usage

## Compile (run) source code

To time the execution of our code, we need to compile the scipts. We use `main.sh`:
```bash
bash main.sh <compile|run> <language> <name> <day> <task>
```
We can also run scripts with `main.sh` (the source code needs to be compiled before running it).

Example of commands:
```bash
bash main.sh compile cpp julo 1 b # Compile julo day 1 task b source code
bash main.sh run ocaml damso 1 b # Run damso day 1 task b s, asummee ocaml damso 1 b has been compiled before
```
for OCaml, make sure to run `eval $(opam env)`.

## Timing 

We use python to measure the execution time, display the performances and print the updated table and copy the output above.

The file `aoc/config.json` allows us to specify `num_runs` and select a subset of `day`, `name`, `language` to run (the code needs to be compiled beforehand as per above). If an argument is `[]`, it will run all possible values of this argument. 

e.g.
```json
{
    "num_runs": 10, //10 runs will be used
    "day":[1,3], // run only day 1 and 3
    "name":[], // for everyone
    "language":[] // for all languages
}
```

Finnaly to run the test 
```bash
./run_test.sh
```


# TODO

- [x] Automatic compiling when the c++/ocaml source exists but not the built file
- [ ] don't measure everything again every day, only new added tasks
- [ ] use https://github.com/sharkdp/hyperfine instead of naive python time measure
- [ ] solve day 2, 3 and 4
- [ ] Dont use N = 1000 for tests but something dynamic to be below a certain maximal testing time
