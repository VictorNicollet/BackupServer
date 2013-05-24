(** Logging events. *)

(** Log out a piece of information *)
let info fmt = 
  Printf.ksprintf (fun s -> print_string "   " ; print_endline s) fmt

(** Log out a critical error *)
let error fmt = 
  Printf.ksprintf (fun s -> print_string "!! " ; print_endline s) fmt 

