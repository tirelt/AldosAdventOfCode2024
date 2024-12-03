open Core
open Stdio

let part1 content =
  let pattern = Re.Perl.compile_pat "mul\\(\\d+,\\d+\\)" in
  let matches = Re.matches pattern content in
  List.map matches ~f:(fun x ->
      let pat = Re.Perl.compile_pat "\\d+" in
      Re.matches pat x)
  |> List.map ~f:(fun x -> List.map x ~f:Int.of_string)
  |> List.map ~f:(fun x -> List.reduce_exn x ~f:( * ))
  |> List.sum (module Int) ~f:Fn.id

let part2 content =
  let patterns = [ ("\n", ""); ("do()", "\n"); ("don't()", "\nIGNORE") ] in
  List.fold patterns ~init:content ~f:(fun acc (pattern, replacement) ->
      String.substr_replace_all ~pattern ~with_:replacement acc)
  |> String.split_lines
  |> List.filter ~f:(fun x -> not (String.is_prefix x ~prefix:"IGNORE"))
  |> List.map ~f:part1
  |> List.sum (module Int) ~f:Fn.id

let solve filename =
  let content = In_channel.read_all filename in
  printf "%d\n" @@ part1 content
  (* printf "%d\n" @@ part2 content *)

let () = solve "../data/day03/input.txt"
