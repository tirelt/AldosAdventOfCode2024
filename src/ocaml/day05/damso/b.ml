open Base
open Stdio

let getRulesAndUpdates lines =
  let rec aux lines rules updates is_rule =
    match lines with
    | [] -> (rules, updates)
    | "" :: xs -> aux xs rules updates false
    | line :: xs ->
        if is_rule then
          aux xs (String.split_on_chars ~on:[ '|' ] line :: rules) updates true
        else aux xs rules (line :: updates) false
  in
  aux lines [] [] true

let getMiddleElement list =
  let rec aux slow fast =
    match fast with
    | [] | [ _ ] -> slow
    | _ :: _ :: rest -> aux (List.tl_exn slow) rest
  in
  match list with
  | [] -> failwith "Empty list has no middle element"
  | _ -> List.hd_exn (aux list list)

let updateWorksWithRules update rules =
  let rec aux rules =
    match rules with
    | [] -> true
    | [ a; b ] :: xs -> (
        match
          ( String.substr_index update ~pattern:a,
            String.substr_index update ~pattern:b )
        with
        | Some ia, Some ib when ia >= ib -> false
        | _ -> aux xs)
    | _ :: xs -> aux xs
  in
  aux rules

let part1 lines =
  let rules, updates = getRulesAndUpdates lines in
  List.fold updates ~init:0 ~f:(fun acc update ->
      if updateWorksWithRules update rules then
        let middle_element =
          update
          |> String.split_on_chars ~on:[ ',' ]
          |> getMiddleElement |> Int.of_string
        in
        acc + middle_element
      else acc)

let createRuleMap rules =
  let table = Hashtbl.create (module String) in
  List.iter rules ~f:(function
    | [ a; b ] ->
        Hashtbl.set table ~key:a ~data:b;
        Hashtbl.set table ~key:b ~data:a
    | _ -> ());
  table

let compareFromRules rule_map =
 fun a b ->
  match Hashtbl.find rule_map a with
  | Some linked when String.equal linked b -> -1
  | Some _ -> 1
  | None -> 0

let part2 lines =
  let rules, updates = getRulesAndUpdates lines in
  let ruleMap = createRuleMap rules in
  let compare = compareFromRules ruleMap in
  List.fold updates ~init:0 ~f:(fun acc update ->
      if not (updateWorksWithRules update rules) then
        let middleElement =
          update
          |> String.split_on_chars ~on:[ ',' ]
          |> List.sort ~compare |> getMiddleElement |> Int.of_string
        in
        acc + middleElement
      else acc)

let solve filename =
  let content = In_channel.read_all filename in
  let lines = String.split_lines content in
  printf "%d\n" @@ part2 lines

let () = solve "./data/day05/input.txt"
