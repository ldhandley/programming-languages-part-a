fun times_until_zero (f,x) =
  if x=0 then 0 else 1 + times_until_zero(f, f x)
(* Not polymorphic! ONLY works with integers. But still a useful higher order
* function *)

fun len xs = 
  case xs of 
       [] => 0
     | x::xs' => 1 + len xs'
(* This is an example of a polymorphic function that's not higher order *)

