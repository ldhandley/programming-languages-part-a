(* Type checker can use patterns to figure out types  *)
(* As long as you don't use #1 and #2 to access contents of tuple and you use
* all the variables in the function, the types can be inferred *)
(* For functions that don't USE all the parts of our function, unused variable
* can be anything *)
fun partial_sum (x,y,z) = 
  z+x
(* y can be 'a *)
(* That's ok! Sometimes the type checker is smarter than you. This function is
* more flexible than you thought. "Unexpected polymorphism" *)
