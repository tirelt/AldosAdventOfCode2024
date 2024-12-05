open Base
open Stdio

let getRulesAndUpdates lines =
  let rec getRulesAndUpdates' lines acc1 acc2 mode =
    match lines with
    | [] -> (acc1, acc2)
    | "" :: xs -> getRulesAndUpdates' xs acc1 acc2 "UPDATES"
    | line :: xs ->
        if String.equal mode "RULES" then
          getRulesAndUpdates' xs (line :: acc1) acc2 mode
        else getRulesAndUpdates' xs acc1 (line :: acc2) mode
  in
  let rules, updates = getRulesAndUpdates' lines [] [] "RULES" in
  (List.map rules ~f:(fun x -> String.split_on_chars ~on:[ '|' ] x), updates)

let getMiddleElement list = List.nth_exn list @@ (List.length list / 2)

let rec updateWorksWithRules update rules =
  match rules with
  | [] -> true
  | [ a; b ] :: xs -> (
      match
        ( String.substr_index update ~pattern:a,
          String.substr_index update ~pattern:b )
      with
      | None, None -> updateWorksWithRules update xs
      | None, _ | _, None -> updateWorksWithRules update xs
      | Some ia, Some ib ->
          if ia < ib then updateWorksWithRules update xs else false)
  | _ :: xs -> updateWorksWithRules update xs

let part1 lines =
  let rules, updates = getRulesAndUpdates lines in
  List.filter ~f:(fun update -> updateWorksWithRules update rules) updates
  |> List.map ~f:(fun update -> String.split_on_chars ~on:[ ',' ] update)
  |> List.map ~f:(fun update -> getMiddleElement update |> Int.of_string)
  |> List.sum (module Int) ~f:Fn.id

let compareFromRules rules =
 fun a b ->
  match
    List.find rules ~f:(fun rule ->
        List.equal String.equal rule [ a; b ]
        || List.equal String.equal rule [ b; a ])
  with
  | Some [ x; y ] -> if String.equal x a && String.equal y b then -1 else 1
  | _ -> 0

let part2 lines =
  let rules, updates = getRulesAndUpdates lines in
  List.filter
    ~f:(fun update -> not @@ updateWorksWithRules update rules)
    updates
  |> List.map ~f:(fun update -> String.split_on_chars ~on:[ ',' ] update)
  |> List.map ~f:(List.sort ~compare:(compareFromRules rules))
  |> List.map ~f:(fun update -> getMiddleElement update |> Int.of_string)
  |> List.sum (module Int) ~f:Fn.id

let solve filename =
  let content = In_channel.read_all filename in
  let lines = String.split_lines content in
  printf "%d\n" @@ part2 lines

let () = solve "./data/day05/input.txt"
