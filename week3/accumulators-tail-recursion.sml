(* How to get to a tail recursion? *)
  (* Create a helper function that takes an accumulator *)
  (* Old base case becomes the initial accumulator *)
  (* New base case becomes final accumulator *)

fun fact n = 
  let fun aux(n,acc) =
    if n=0
    then acc
    else aux(n-1,acc*n)
  in
    aux(n,1)
  end

(*Normal recursion*)
fun sum xs = 
  case x2 of
       [] => 0
     | x::xs' => x + sum xs'

(*Tail recursion*)
fun sum2 xs = 
let fun aux(xs,acc) = 
  case xs of
    []=acc
     | x::xs' => aux(xs',x+acc)
  in 
    aux(xs, 0)
end

fun rev xs = 
  case xs of
       [] => []
     | x::xs' => (rev xs') @ [x]
(*Super inefficient! Appending at each step is O(k^2). Gets really bad as list
* gets larger. *)

fun rev2 xs = 
  let fun aux(xs,acc) =
    case xs of
         [] => acc
       | x::xs' => aux(xs', x::acc)
  in
    aux(xs,[])
  end


