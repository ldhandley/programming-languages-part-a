val a = 10

(* a : int
  a -> 10 *)

val b = a * 2

(* b -> 20 *)

val a = 5 (* this is not an assignment statement *)

(* a -> 5, b -> 20 *)

val c = b

(* a -> 5, b -> 20, c -> 20 *)

val d = a

(* a -> 5, b -> 20, c -> 20, d -> 5  *)

val a = a + 1

(* a -> 6, b -> 20, c -> 20, d -> 5  *)

val f = a * 2

(* a -> 6, b -> 20, c -> 20, d -> 5, f -> 12  *)

(* Can't forward reference variables (can't refer to a variable before you've
* defined it) *)


