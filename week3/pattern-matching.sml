(* datatype t= C1 of t1 | C2 of t2 | ... | Cn of tn *)

(* C1,C2,...,Cn = constructors of type ti->t *)
  (* Cn v is a value (the value includes the tag which is the constructor type) *)

(* Constructor can also omit "of t", no underlying data *)

(* case e of p1 => e1 | p2 => e3 | ... | pn => en *)
(* Evaluate e to a value, v *)
(* If p1 is the first pattern to match v, then result is evaluation of ei in
  * environment "extended by match"*)
