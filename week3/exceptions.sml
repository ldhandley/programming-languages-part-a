fun hd xs = 
  case xs of
       [] => raise List.Empty
     | x::_ => x
(* Built in exceptions. You can also define your own: *)
exception MyUndesirableCondition
exception MyOtherException of int*int
(* This second one allows you to pass data out, like MyOtherException(3,4) *)

fun mydiv (x,y) =
  if y=0
  then raise MyUndesirableCondition
  else x div y

(* Exceptions have type exn. You can use functions to pass around exn *)
fun maxlist (xs,ex) =
  case xs of
       []=> raise ex
     |x::[] =>x
     |x::xs' => Int.max(x, maxlist(xs', ex))
val w = maxlist([3,4,5],MyUndesirableCondition)
val x = maxlist([3,4,5],MyUndesirableCondition) 
        handle MyUndesirableCondition => 42
(* val y = maxlist([],MyUndesirableCondition) *)
val z = maxlist([],MyUndesirableCondition) 
        handle MyUndesirableCondition => 42
(* No exceptions will be thrown in these. Any exceptions are handled. *)

(* Exceptions are a lot like datatype constructors. *)
(* Declaring an exception makes a constructor for type exn *)
(* Can pass values of exn anywhere *)
(* Handle can have multiple branches with patterns for type exn *)
