(* Lists are polymorphic type constructors *)
(* int list and string list and int list list are all types! list by itself is
* not a type *)
(* Options are the same way. *)
(* Lists and Options take type parameters to create types (type constructors) *)
(* You don't need to understand this for the homework *)
(* Functions can be polymorphic -- Can accept multiple types with 'a *)
(* SML lets you define new polymorphic datatypes *)

datatype 'a option = NONE | SOMEdatatype 'a option = NONE | SOME of 'a
datatype 'a mylist = Empty | Cons of 'a * 'a mylist
datatype ('a,'b) tree = 
        Node of 'a * ('a,'b) tree * ('a,'b) tree
        | Leaf of 'b

(* Functions will be polymorphic or not depending on how the data is used! *)
