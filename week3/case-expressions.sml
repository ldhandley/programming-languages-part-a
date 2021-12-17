(* Case expressions: construct that we will use to access values of datatype
* bindings *)

datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza


(* mytype->int *)
fun f (x: mytype) =
  case x of
       Pizza => 3
     | Str s => 8
     | TwoInts(i1,i2) => i1+i2

(* Multi-branch conditional to pick branch based on variant *)
(* Extracts data and binds to variables local to that branch *)
(* Type-checking: all branches must have same type (int for example above) *)
(* Evaluation: evaluate between case... of and the right branch *)
(* Pattern is part left of the => (called pipe) *)
  (* Looks like an expression but NOT - these can't be evaluated *)
  (* For this session, a pattern is just a constructor name & the correct # of
                                     * variables, C or C(x) or C(x,y) *)

(* If you forget one of the constructors for mytype, it'll warn you about
* missing cases! *)

(* Benefits to this approach: *)
  (* You can't forget a case! *)
  (* You can't duplicate a case. *)
  (* You will not forget to test the variant correctly and get an exception
  * (e.g. hd [])*)
  (* Pattern-matching can be generalized and made more powerful, leading to
  * elegant, concise code *)
