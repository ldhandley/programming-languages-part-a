(*takes a function and curries it:*)
fun curry f x y => f (x,y)

fun uncurry f (x,y) = f x y

fun other_curry f = fn x => fn y => f y x (* this is without syntactic sugar *)

fun range (i,j) = if i>j then [] else i::range(i+1,j)

val countup = (curry range) 1


