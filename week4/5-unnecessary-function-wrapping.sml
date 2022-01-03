fun n_times (f,n,x) = 
  if n=0
  then x
  else f (n_times(f,n-1,x))

fun nth_tail (n,xs) = n_times((fn y -> tl y),n,xs)
(*This is inferior style*)

fun nth_tail (n,xs) = n_times(tl,n,xs)
(*BETTER! tl does exactly what the last function does but shorter and easier to
* read. The other is unnecessary function wrapping *)

(* Redefining the List.rev utility function: *)
fun rev xs = List.rev xs
(* Better is this: *)
val rev = List.rev
