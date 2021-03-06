fun filter (f, xs) = 
  case xs of 
       [] => []
     | x::xs' => if f x then x::(filter(f, xs')) else filter(f,xs')

fun greaterThanX x = fn y => y > x (* int -> (int->bool) *)
fun noNegatives xs = filter(greaterThanX ~1, xs)
fun allGreater (xs,n) = filter(fn x => x>n, xs)

