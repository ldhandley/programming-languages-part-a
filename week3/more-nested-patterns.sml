(* Returns true if you never find a number smaller than the one before it *)
fun nondecreasing xs = (* int list -> bool *)
  case xs of 
       [] => true
      | _::[] => true
      | head::(neck::rest) => head <= neck 
                              andalso nondecreasing (neck::rest)

(* Should use _ when you don't end up whatever variable you would have defined
* in the following expression. You don't need what's in the position, you just
* need that it's there. _ doesn't create a local variable binding that you don't
* need. *)

datatype sgn = P | N | Z

fun multsign (x1,x2) = 
  let fun sign x = if x=0 then Z else if x>0 then P else N
  in
    case (sign x1, sign x2) of
         (Z,_) => Z
       |(_,Z) => Z
       |(P,P) => P
       |(P,N) => N
       |(N,P) => N
       |(N,N) => P
  end

fun length xs = 
  case xs of
       [] => 0
     | _::xs' => 1 + length xs'


