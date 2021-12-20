(* Big reveals: *)
(* Every val-binding and function-binding uses pattern-matching *)
(* Every function in ML takes exactly ONE argument! *)
(* To understand, we first need to extend our definition of pattern-matching *)

(* Poor style, but the only way to use patterns so far *)
(* These are examples on each of types instead of one of types *)
fun sum_triple triple =
  case triple of
       (x,y,z) => x+y+z

fun full_name r = 
  case r of
       {first=x, middle=y, last=z} => x ^ " " ^ y ^ " " ^ z

(* Val-binding actually uses pattern, val p = e, where p is a pattern, not just
* a variable. Variable are just one type of pattern. *)

(* int*int*int => int *)
fun sum_triple triple =
  let val (x,y,z) = triple
  in
    x+y+z
  end

(* This uses a record pattern *)
fun full_name r = 
  let val {first=x, middle=y, last=z} = r
  in
      x ^ " " ^ y ^ " " ^ z
  end

(* But there's yet a better way to do this... *)
(* Function argumens can ALSO be a pattern! *)
(* fun f p = e, where p is a pattern (match against argument in function call) *)

fun sum_triple_best(x,y,z) =
  x + y + z

fun full_name {first=x, middle=y, last=z} =
      x ^ " " ^ y ^ " " ^ z

(* On HW2, not allowed to use # and don't need to write down explicit types! *)

(* sum_triple_best LOOKS like a function that takes 3 arguments... but it's
* actually a function that just takes 1 argument, a triple! *)
(* all functions in ML take 1 argument, a tuple!!! *)
(* The function hello() takes an argument of type unit and () is a pattern to
* match the only value of type unit *)
(* All ML functions take 1 argument - there are no multi-argument functions! *)
(* This is implemented by using pattern matching, so you get the different
* pieces of that tuple out *)

(* In ML, every function takes and returns 1 argument. This makes it easier to
* pass the results of one function along to another *)
(* Zero arguments is the unit pattern () matching the unit value () *)


