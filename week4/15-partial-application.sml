fun sorted3 x y z = z>=y andalso y>=x

fun fold f acc xs = 
  case xs of
       [] => acc
     |x:xs' => fold f (f(acc,x)) xs'

val is_nonnegative = sorted3 0 0
(* fn z => z>=0 andalso 0>=0 *)

val sum = fold (fn (x,y) => x+y) 0
(* returns a function that would sum all elements in a list *)

val sum_inferior xs = fold (fn (x,y) => x+y) 0 xs
(* This is unnecessary function wrapping *)
(* Use the shorter way instead! *)

fun range i j = if i > j then [] else i :: range (i+1) j
  (* range 3 6  [3,4,5,6] *)

val countup = range 1
(* countup 6  [1,2,3,4,5,6] *)

fun countup_inferior x = range 1 x

(* common style is to curry higher-order functions with function
* arguments first to enable convenient partial application  *)

fun exists predicate xs = 
  case xs of
       [] => false 
     | x::xs' => predicate x orelse exists predicate xs'

val no = exists (fn x => x=7) [4,11,23]

val hasZero = exists (fn x => x=0) (* int list -> bool*)

val incrementAll = List.map (fn x => x + 1) (* built in functions are often
curried. This returns a function of type int list -> int list *)

val removeZeros = List.filter (fn x => x <> 0)

(* val pairWithOne = List.map (fn x => (x,1)) This throws an error because it
* would return a polymorphic function...  *)

(* workarounds for value restriction warning, use that "unnecessary" function
* wrapping *)

fun pairWithOne xs = List.map (fun x => (x,1)) xs

(* can also explicitly add types *)

fun pairWithOne : string list -> (string * int) list = List.map (fn x => (x,1))
