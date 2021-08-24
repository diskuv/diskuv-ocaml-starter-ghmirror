(* The "Complete Program" code example from Real World OCaml.

   Source and explanation: https://dev.realworldocaml.org/guided-tour.html ; UNLICENSE: https://github.com/realworldocaml/book/blob/0f3e9708174115d133ecd6993a6070288f9eb221/LICENSE.md
*)

open Base
open Stdio

let rec read_and_accumulate accum =
  let line = In_channel.input_line In_channel.stdin in
  match line with
  | None -> accum
  | Some x -> read_and_accumulate (accum +. Float.of_string x)

let () = printf "Total: %F\n" (read_and_accumulate 0.)
