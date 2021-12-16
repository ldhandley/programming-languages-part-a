(* Records: you can assign any expression on the right of each = *)
(* Similar to tuples in that they are both an "each of" compound type *)
val x = {bar=(1+2,true andalso true), foo=3+4,baz=(false,9)};

val my_niece = {name="Amelia", id=41123};

val a_pair = (3+1, 4+2);
val another_pair = {2=3+1, 1=4+2};

(* use #field_name to get access to values *)
(* #id my_niece *)

(* #1 a_pair + #2 another_pair *)
(* This turns a Record into a Tuple! (Why? Because there's no such thing as
* Tuples in ML! There are just a special kind of Record that gets printed
* differently.) The REPL will always use as Tuples if it can. THIS is syntactic
* sugar. *)

(* Tuples are just records with field name 1 -> n. Tuples are just a particular
* way of writing particular records. *)
