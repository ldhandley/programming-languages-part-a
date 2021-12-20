(* type aname = t *)
(* now you can use aname and t interchangeably *)

datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int

type card = suit * rank
type name_record = { student_num: int option,
                     first: string,
                     middle: string option,
                     last: string }

fun is_Queen_Of_Spades (c: card) = 
  #1 c = Spade andalso #2 c = Queen

val c1: card = (Diamond, Ace) (* notice how we declare type of variable name
with : type before the = sign *)
val c2: suit * rank = (Heart, Ace)
val c3 = (Spade, Ace) (* type is both card and suit * rank *)

(* You can call is_Queen_Of_Spades on all 3 of these variables even though they
* may appear to have different types *)

fun is_Queen_of_Spade2 c = 
  case c of
       (Spade, Queen) => true
     | _ => false
(* Notice how we didn't have to include the type of c in the parameters *)

(* type synonym are convenient. Just use card instead of suit * rank *)
(* type synonyms don't let us do anything new though *)


