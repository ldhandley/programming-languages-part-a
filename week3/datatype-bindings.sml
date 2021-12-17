(* datatype mytype = TwoInts of int * int 
* | Str of string
* | Pizza
* *)

(* Introduces a new type (mytype) to the environment *)
(* Also adds constructors TwoInts, Str, and Pizza *)
(* These constructors are functions from int*int->mytype, string -> mytype, and
* Pizza is already of type mytype *)

datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza

val a = Str "hi"
val b = Str
val c = Pizza
val d = TwoInts(1+2,3+4)
val e = a

(* Need a way to check what variant (which constructor made it) *)
(* and a way to extract data *)


