fun compose(f,g) = fn x => f(g x)
(* ('b -> 'c) * ('a ->'b) -> ('a -> 'c) *)

(* provided in ML as an infix operator *)
(* f o g *) 
(* this is exactly the function we wrote above! *)

(* int -> real *)
fun sqrt_of_abs i = Math.sqrt (Real.fromInt (abs i))

fun sqrt_of_abs2 i = (Math.sqrt o Real.fromInt o abs) i

fun sqrt_of_abs3 = Math.sqrt o Real.fromInt o abs

(* |> or !> *)
infix !>

fun x !> f = fx
fun sqrt_of_abs4 i = i !> abs !> Real.fromInt !> Math.sqrt

fun backup1 (f,g) = 
  fn x => case f x of NONE => g x
                      |SOME y => y

