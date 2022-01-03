fun sorted3_tupled (x,y,z) = z>=y andalso y>=x

val t1 = sorted3_tupled(7,9,11)

(* new way: currying *)
val sorted3 = fn x => fn y => fn z => z>=y andalso y>=x
(* same as: fun sorted3 x = fn y => fn z => ... *)

val t2 = ((sorted3 7) 9) 11
(* Calling (sorted3 7) returns a closure! *)
  (* Code: fn y => fn z => z>=y andalso y>=x *)
  (* Environment maps x to 7 *)
(* Calling that closure with 9 returns a closure with: *)
  (* Code: fn z => z>=y andalso y>=x *)
  (* Environment maps x to 7, y to 9 *)
(* Calling that closure with 11 returns true *)

val t3 = sorted3 7 9 11
(* This is equivalent to the above! No need to parentheses *)

fun sorted3_nicer x y z = z>=y andalso y>=x
(* This is syntactic sugar for sorted3 - WAY cleaner *)

val t4 = sorted3_nicer 7 9 11

(* Curried version of fold *)
fun fold f acc xs = 
  case xs of
       [] => acc
     |x:xs' => fold f (f(acc,x)) xs'

fun sum xs = fold (fn (x,y) => x+y) 0 xs
