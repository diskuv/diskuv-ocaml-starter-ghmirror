(* The "Variants" code example from Real World OCaml.

  Source and explanation: https://dev.realworldocaml.org/variants.html ; UNLICENSE: https://github.com/realworldocaml/book/blob/0f3e9708174115d133ecd6993a6070288f9eb221/LICENSE.md
 *)
open Base
open Stdio

type basic_color =
  | Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White

let basic_color_to_int = function
  | Black -> 0
  | Red -> 1
  | Green -> 2
  | Yellow -> 3
  | Blue -> 4
  | Magenta -> 5
  | Cyan -> 6
  | White -> 7

let color_by_number number text =
  Printf.sprintf "\027[38;5;%dm%s\027[0m" number text

let blue = color_by_number (basic_color_to_int Blue) "Blue"
