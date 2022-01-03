fun f g =  
  let 
    val x = 3 (*irrelevant*)
  in
    g 2
  end

val x = 4
fun h y = x + y (* this will always add 4 to its argument *)

val z = f h (* 6 *)
