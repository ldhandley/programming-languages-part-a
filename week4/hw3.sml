
(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

val only_capitals =
  List.filter (fn (e) => Char.isUpper(String.sub(e, 0)))

val longest_string1 = 
  foldl (fn (e1,acc) => if String.size(e1) > String.size(acc)
                        then e1
                        else acc) ""

val longest_string2 = 
  foldl (fn (e1,acc) => if String.size(e1) >= String.size(acc)
                        then e1
                        else acc) ""

fun longest_string_helper f = 
  foldl (fn (x,y) => if f(x, y)
                     then x
                     else y)
        ""

val longest_string3 =
  longest_string_helper (fn (x,y) => String.size x > String.size y) 

fun longest_string4 l =
  longest_string_helper (fn (x,y) => String.size x >= String.size y) l 

val longest_capitalized  = 
   longest_string1 o only_capitals

val rev_string = 
  String.implode o List.rev o String.explode

fun first_answer f l =
  case l of 
       [] => raise NoAnswer
      |x::xs' =>
         case (f x) of
              NONE => first_answer f xs'
            |SOME valu => valu

fun all_answers f l = 
  let 
    fun helper f acc l = 
      case l of
           [] => SOME acc 
           | x::xs' => case (f x) of
                        NONE => NONE
                       |SOME valu => helper f (acc @ valu) xs'
  in
    helper f [] l
  end

fun count_wildcards pattern =
  g (fn () => 1) (fn x => 0) pattern

fun count_wild_and_variable_lengths pattern = 
  g (fn () => 1) (fn x => String.size(x)) pattern

fun count_some_var (str, pattern) =
  g (fn () => 0) (fn x => if(String.isSubstring str x) then 1 else 0) pattern

