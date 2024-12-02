open Base
open Stdio

let initialTrend = -999

let rec isLineSafe line currentTrend =
  match line with
  | [] -> true
  | _ :: [] -> true
  | x1 :: x2 :: xs ->
      let trend = if x1 < x2 then 1 else if x1 > x2 then -1 else 0 in
      if
        Int.abs (x2 - x1) > 3
        || trend = 0
        || (currentTrend <> initialTrend && trend <> currentTrend)
      then false
      else isLineSafe (x2 :: xs) trend

let isLineSafeWithTolerance line =
  let valid = ref false in
  let i = ref 0 in
  while (not !valid) && !i < List.length line do
    let lineWithoutIthElement = List.filteri ~f:(fun j _ -> j <> !i) line in
    if isLineSafe lineWithoutIthElement initialTrend then valid := true
    else Int.incr i
  done;
  !valid

let rec smartIsLineSafeWithTolerance ?previous line currentTrend =
  match line with
  | [] -> true
  | _ :: [] -> true
  | x1 :: x2 :: xs ->
      let trend = if x1 < x2 then 1 else if x1 > x2 then -1 else 0 in
      if
        Int.abs (x2 - x1) > 3
        || trend = 0
        || (currentTrend <> initialTrend && trend <> currentTrend)
      then
        isLineSafe (x1 :: xs) currentTrend
        ||
        match previous with
        | Some p -> isLineSafe (p :: x2 :: xs) currentTrend
        | None -> isLineSafe (x2 :: xs) currentTrend
      else smartIsLineSafeWithTolerance ~previous:x1 (x2 :: xs) trend

let part1 lines =
  List.map lines ~f:(fun line -> String.split_on_chars ~on:[ ' ' ] line)
  |> List.map ~f:(fun line -> List.map line ~f:Int.of_string)
  |> List.count ~f:(fun line -> isLineSafe line initialTrend)

let part2 lines =
  List.map lines ~f:(fun line -> String.split_on_chars ~on:[ ' ' ] line)
  |> List.map ~f:(fun line -> List.map line ~f:Int.of_string)
  |> List.count ~f:(fun line -> isLineSafeWithTolerance line)

let solve filename =
  let content = In_channel.read_all filename in
  let lines = String.split_lines content in
  printf "%d\n" @@ part1 lines;
  printf "%d\n" @@ part2 lines

let () = solve "input"
