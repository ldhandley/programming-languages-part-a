val x = 1

fun f y = 
  let
    val x = y+1
  in
    fn z => x + y + z (* take z and return 2y+1+z *)
  end

val x = 3 (* irrelevant! *)

val g = f 4 (* returns a function that adds 9 to its arguments *)

y = 5 (* irrelevant *)

val z = g 6 (* get 15 *)

(* If we had a different call to f like `f 8`, this would return a different
* closure with a different environment (y is 8 and x is 9) and that would return
* a function that always added 17 to its argument *)
