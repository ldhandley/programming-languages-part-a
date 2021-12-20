(* Type 'a list * 'a list -> 'a list: though 'a can be anything must be the SAME
* anything in all three spots *)

(* Easy rule you (and the typechecker can apply without thinking): *)
(* A type t1 is more general than the type t2 if you can take t1, replace its
* type variables consistently, and get t2 *)

(* ''a are equality types. These can be anythign that an operator works on, such
* as int, string, tuples, but not functions, real, ... *)

(* ''a * ''a -> string *)
fun same_thing(x,y) =
  if x=y then "yes" else "no"
