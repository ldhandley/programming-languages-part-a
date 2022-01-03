val x = 1 
(* x maps to 1 *)
fun f y = x + y
(* f maps to a function that adds 1 to its argument *)
(* This will be the case WHEREVER f is called *)
(* This is an example of lexical scope *)

val x = 2
(* x maps to 2. This has NO EFFECT on function f *)
val y = 3

val z = f(x + y)
(* call the function defined above with 5 *)
(* z maps to 6 *)

