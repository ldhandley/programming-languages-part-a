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

(**** you can put all your code here ****)

(* 1. Write a function only_capitals that takes a string list and returns a string list that has only the strings
in the argument that start with an uppercase letter. Assume all strings have at least 1 character.
Use List.filter, Char.isUpper, and String.sub to make a 1-2 line solution *)
val only_capitals = List.filter(fn str => Char.isUpper(String.sub(str, 0)))

(* 2. Write a function longest_string1 that takes a string list and returns the longest string in the list.
If the list is empty, return "". In the case of a tie, return the string closest to the beginning of the list.
Use foldl, String.size, and no recursion (other than the implementation of foldl is recursive). *)
fun longest_string1 strlist =
	case strlist
		of [] => ""
		 | x::xs' => foldl(fn(x, y) => if String.size(x) > String.size(y) then x else y) "" (x::xs')

(* 3. Write a function longest_string2 that is exactly like longest_string1 except in the case of ties it
returns the string closest to the end of the list. Your solution should be almost an exact copy of longest_string1. 
Still use foldl and String.size. *)
fun longest_string2 strlist =
	case strlist
		of [] => ""
		 | x::xs' => foldl(fn(x, y) => if String.size(x) >= String.size(y) then x else y) "" (x::xs')

(* 4. Write functions longest_string_helper, longest_string3, and longest_string4 such that:
??? longest_string3 has the same behavior as longest_string1 and longest_string4 has the
same behavior as longest_string2.
??? longest_string_helper has type (int * int -> bool) -> string list -> string
(notice the currying). This function will look a lot like longest_string1 and longest_string2 but is more general
because it takes a function as an argument.
??? If longest_string_helper is passed a function that behaves like > (so it returns true exactly when its first argument
is stricly greater than its second), then the function returned has the same behavior as longest_string1.
??? longest_string3 and longest_string4 are defined with val-bindings and partial applications of longest_string_helper. *)
fun longest_string_helper f = foldl(fn(x, y) => if f(String.size(x), String.size(y)) then x else y) ""
val longest_string3 = longest_string_helper(fn (x, y) => x > y)
val longest_string4 = longest_string_helper(fn (x, y) => x >= y)

(* 5. Write a function longest_capitalized that takes a string list and returns the longest string in the
list that begins with an uppercase letter, or "" if there are no such strings. Assume all strings have at least 1 character.]
Use a val-binding and the ML library???s o operator for composing functions. Resolve ties like in problem 2. *)
val longest_capitalized = longest_string3 o only_capitals;

(* 6. Write a function rev_string that takes a string and returns the string that is the same characters in reverse order.
Use ML???s o operator, the library function rev for reversing lists, and two library functions in the String module.
(Browse the module documentation to find the most useful functions.) *)
val rev_string = String.implode o List.rev o String.explode;

(* 7. Write a function first_answer of type (???a -> ???b option) -> ???a list -> ???b (notice the 2 arguments are curried).
The first argument should be applied to elements of the second argument in order until the first time it returns SOME
v for some v and then v is the result of the call to first_answer. If the first argument returns NONE for all list elements,
then first_answer should raise the exception NoAnswer. Hints: Sample solution is 5 lines and does nothing fancy. *)
fun first_answer f y =
	case y
		of [] => raise NoAnswer
		 | x::xs' =>
		 	case f x
			 	of SOME v => v
				 | NONE => first_answer f xs'

(* 8. Write a function all_answers of type (???a -> ???b list option) -> ???a list -> ???b list option (notice the 2 arguments are curried).
The first argument should be applied to elements of the second argument. If it returns NONE for any element,
then the result for all_answion is 8 lines. It uses a helper function with an accumulator and uses @.
Note all_answers f [] should evaluate to SOME []. *)
fun all_answers f y=  
    let 
      val hasNone = List.exists(fn x => f(x) = NONE)
      val final_result = List.foldl(fn(x, acc) => (case f(x) of SOME v => v@acc ))
    in 
		case y
			of [] => SOME []
			 | _ => if hasNone y then NONE else SOME(final_result [] y)
    end  

(* 9a. Use g to define a function count_wildcards that takes a pattern and returns how many Wildcard patterns it contains. *)
fun count_wildcards pat = g (fn _ => 1) (fn _ => 0) pat

(* 9b. Use g to define a function count_wild_and_variable_lengths that takes a pattern and returns the num of the string lengths of all the variables in the variable patterns it contains.
(Use String.size. We care only about variable names; the constructor names are not relevant.) *)
val count_wild_and_variable_lengths = g (fn _ => 1) String.size

the number of times the string appears as a variable in the pattern. We care only about variable names;
the constructor names are not relevant. *)
fun count_some_var(str, pat) = g (fn _ => 0) (fn x => if x = str then 1 else 0) pat

(* 9c. Use g to define a function count_some_var that takes a string and a pattern (as a pair) and returns the number
of times the string appears as a variable in the pattern. We care only about variable names;
the constructor names are not relevant. *)

(* 10. Write a function check_pat that takes a pattern and returns true if and only if all the variables appearing
in the pattern are distinct from each other (i.e., use different strings). The construc second takes a
list of strings and decides if it has repeats. List.exists may be useful. Sample solution is 15 lines.
These are hints: We are not requiring foldl and List.exists here, but they make it easier. *)
val check_pat = let
	fun helper1 p = case p of
		Variable x => [x]
		| TupleP ps => List.foldl(fn (x, acc) => helper1(x) @ acc) [] ps
		| _ => []

	fun helper2 str_list = case str_list of
	   [] => true
	 | x::xs' => if List.exists(fn y => y = x) xs' then false else helper2(xs')	
in
  helper2 o helper1
end

(* 11. Write a function match that takes a valu * pattern and returns a (string * valu) list option, namely NONE
if the pattern does not match and SOME lst where lst is the list of bindings if it does.  has one case
expression with 7 branches. The branch for tuples uses all_answers and ListPair.zip. Sample solution is 13 lines. Remember
to look above for the rules for what patterns match what values, and what bindings they produce.
These are hints: We are not requiring all_answers and ListPair.zip here, but they make it easier. *)
fun match(v : valu, p : pattern) = case (v, p) of
   (_, Wildcard) => SOME []
 | (Unit, UnitP) => SOME []
 | (Const x, ConstP y) => if x = y then SOME [] else NONE
 | (Constructor (str1 , v),ConstructorP (str2, p) ) => if str1 = str2 then match(v, p) else NONE
 | (Tuple vlist, TupleP plist) => if List.length vlist = List.length plist
								  then case all_answers match (ListPair.zip(vlist, plist)) of
									 SOME v => SOME v
									 | _ => NONE
								  else NONE
 | (_, Variable str) => SOME [(str, v)]
 | _ => NONE

(* 12. Write a function first_match that takes a value and a list of patterns and returns a (string * valu) list option,
namely NONE if n first_answer and a handle-expression. Hints: Sample solution is 3 lines. *)
fun first_match v plist = SOME (first_answer (fn p => match(v, p)) plist)
							handle NoAnswer => NONE
