fun filter (f, xs) = 
  case xs of 
       [] => []
     | x::xs' => if f x then x::(filter(f, xs')) else filter(f,xs')

(* This recomputes size of s every time we call this *)
fun allShorterThan1 (xs, s) =
  filter (fn x => String.size x < String.size s, xs)

fun allShorterThan2 (xs, s) = 
  let
    val i String.size s
  in
    filter(fn x => String.size x< i, xs)
  end
(* This avoids the recomputation of String.size s because filter closes over
* the variable i in the anonymous function (the code and the lexical environment are baked together) and
* that's what's used recursively inside of filter *)


