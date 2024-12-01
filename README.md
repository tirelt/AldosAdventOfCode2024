# AldosAdventOfCode2024

Repo to store the compiled AoC24 codes of Aldo's members and compare the execution times.
`Leaderboard.md` keeps track of the times.

## How does it work

The execution is made from the day (e.g. `day01`) folders with the `launch.sh` executable file. An `input` of the day problem is directly in the folder, the programs need to load `input` from the `cwd`.

`launch.sh` will lauch `RUNS` times the programs in the `programs` list. 
`programs` should look like:
```Bash
programs=(
    "./theo"
    "./damso"
    "./julo"
    )
```
To make `launch.sh` executable:
```Bash
chmod +x run_with_time.sh
```
