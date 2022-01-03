(* map: take any list, apply f to every function in that list *)
fun map(f,xs) = 
  case xs of
       [] => []
     | x:xs' => (f x)::map(f,xs')

val x = map((fn x => x+1), [4,8,12,16])
val x2 = map(hd, [[1,2],[3,4],[5,6,7]])

(* filter: filter out any elements of a list that return false when the function
* is applied *)
fun filter (f,xs) = 
  case xs of
       []=>[]
     |x:xs' => if f x
               then x::(filter (f, xs'))
               else filter(f,xs')

fun is_even v = 
  (v mod 2 = 0)
(*returns only elemnts of a list that are even*)
fun all_even xs = filter(is_even, xs)
(*takes pairs, and then returns only elements where the 2nd element is even*)
fun all_even_snd xs = filter((fn (_,v) => is_even v),xs)
