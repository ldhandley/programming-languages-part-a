datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int

datatype id = StudentNum of int
            | Name of string
            * (string option)
            * string
(* Datatypes here are often called Enums or Enumerations in other languages *)

(*
* {* use the student_num and ignore other fields unless the student_num is ~1 *}
* { student_num: int,
*   first: string,
*   middle: string option,
*   last: string
* }
* This approach is bad style...
* By using a record you give up benefits of the language enforcing every value
* is one variant, you can't forget branches, etc.
* It's also confusing - you HAVE to read comment to understand
* If instead the point is that every person in your program has a name and maybe
* a student number, this kind of each-of way is the best approach 
* *)

datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp

(* This example uses self-reference! *)
(* Add (Constant (10+9), Negate (Constant 4)) *)
(* Every value of type exp will look like a tree *)

fun eval e =
  case e of
       Constant i => i
     |Negate e2 => ~(eval e2)
     |Add(e1,e2) => (eval e1) + (eval e2)
     |Multiply(e1,e2) => (eval e1) * (eval e2)

fun number_of_adds e = (* exp -> int *)
  case e of
       Constant i => 0
     |Negate e2 => number_of_adds e2
     |Add(e1,e2) => 1 + number_of_adds e1 + number_of_adds e2
     |Multiply(e1,e2) => number_of_adds e1 + number_of_adds e2 

val example_exp: exp = Add(Constant 19, Negate (Constant 4))
val example_ans: int = eval example_exp
val example_addCount = number_of_adds (Multiply(example_exp,example_exp))

