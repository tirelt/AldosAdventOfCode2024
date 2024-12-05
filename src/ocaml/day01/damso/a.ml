open Base
open Stdio

let lineToInts line =
  let formattedLine =
    String.substr_replace_all ~pattern:"   " ~with_:" " line
  in
  let parts = String.split_on_chars ~on:[ ' ' ] formattedLine in
  List.map parts ~f:Int.of_string

let rec linesToLists lines acc1 acc2 =
  match lines with
  | [] -> (acc1, acc2)
  | x :: xs ->
      let ints = lineToInts x in
      linesToLists xs (List.nth_exn ints 0 :: acc1) (List.nth_exn ints 1 :: acc2)

let rec accumulatedDiff l1 l2 =
  match (l1, l2) with
  | [], [] -> 0
  | [], _ | _, [] -> 0
  | x :: xs, y :: ys ->
      let diff = if x - y > 0 then x - y else y - x in
      diff + accumulatedDiff xs ys

let part1 lines =
  let first, second = linesToLists lines [] [] in
  let sortedFirst = List.sort ~compare:Int.compare first in
  let sortedSecond = List.sort ~compare:Int.compare second in
  accumulatedDiff sortedFirst sortedSecond

let rec similarity l1 l2 =
  match (l1, l2) with
  | [], [] -> 0
  | [], _ | _, [] -> 0
  | x :: xs, l -> (x * List.count l ~f:(fun i -> i = x)) + similarity xs l

let part2 lines =
  let first, second = linesToLists lines [] [] in
  similarity first second

let solve filename =
  let content = In_channel.read_all filename in
  let lines = String.split_lines content in
  printf "%d\n" @@ part1 lines

let () = solve "./data/day01/input.txt"