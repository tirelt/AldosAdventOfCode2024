open Base
open Stdio

let getWordFromCoordinatesAndDirection matrix x y dx dy length =
  let rec getWordFromCoordinatesAndDirection' x y dx dy acc length =
    if
      length = 0 || x < 0 || y < 0
      || x >= Array.length matrix.(0)
      || y >= Array.length matrix
    then acc
    else
      let nextX = x + dx in
      let nextY = y + dy in
      getWordFromCoordinatesAndDirection' nextX nextY dx dy
        (acc ^ String.of_char matrix.(y).(x))
        (length - 1)
  in
  getWordFromCoordinatesAndDirection' x y dx dy "" length


let part2 matrix =
  let rows = Array.length matrix.(0) in
  let cols = Array.length matrix in
  let result = ref 0 in
  for x = 0 to rows - 1 do
    for y = 0 to cols - 1 do
      if Char.equal matrix.(y).(x) 'A' then
        let leftToRightDiag =
          getWordFromCoordinatesAndDirection matrix (x - 1) (y - 1) 1 1 3
        in
        let rightToLeftDiag =
          getWordFromCoordinatesAndDirection matrix (x + 1) (y - 1) (-1) 1 3
        in
        if
          (String.equal leftToRightDiag "MAS"
          || String.equal leftToRightDiag "SAM")
          && (String.equal rightToLeftDiag "MAS"
             || String.equal rightToLeftDiag "SAM")
        then result := !result + 1
    done
  done;
  !result

let solve filename =
  let content = In_channel.read_all filename in
  let lines = String.split_lines content in
  let matrix = Array.of_list (List.map lines ~f:String.to_array) in
  printf "%d\n" @@ part2 matrix

let () = solve "../data/day04/input.txt"
