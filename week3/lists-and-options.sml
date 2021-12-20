(* Recursive datatypes *)

datatype my_int_list = Empty
                     | Cons of int * my_int_list

val x = Cons(4, Cons(23, Cons(2008, Empty)))

fun append_my_list (xs, ys) =
  case xs of
       Empty => ys
     | Cons(x,xs') => Cons(x, append_my_list(xs', ys))

(* Options are just datatypes! *)
(* NONE & SOME are constructors, not just functions *)
(* So you should use pattern-matching instead of isSome and valOf *)

fun inc_or_zero intoption = 
  case intoption of
       NONE => 0
     |SOME i => i+1

(* NONE is a datatype that carries no value *)
(* SOME is a datatype that carries one value *)

(* Lists are datatypes too! *)
(* Don't use hd, tl, null anymore *)
(* [] and :: are CONSTRUCTORS too - just weird syntax, particularly infix :: *)

fun sum_list xs = 
  case xs of
       [] => 0
     | x::xs' => x + sum_list xs'

fun append (xs,ys) =
  case xs of
       [] => ys
     | x:: xs' => x::append(xs',ys)

(* Why do this? You won't forget cases! You won't accidentally call tl on an
* empty list. *)

(* HW2: Not allowed to use isSome,valOf,null,hd,tl! MUST USE PATTERN MATCHING *)


