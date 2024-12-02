# AldosAdventOfCode2024

Repo to store the compiled AoC24 codes of Aldo's members and compare the execution times.

# Source files

- [theo](https://github.com/tirelt/AdventOfCode/tree/master/2024)

## Leaderboard

in ms
| day | theo | damso | julo |
:------:|:-----|:----:|:-----:|
|1|0.4|0.3||
|2|0.2|0.2||
|3|0.2|||
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
chmod +x launch.sh
```
To run the codes
```Bash
./launch.sh
```
