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

fun only_capitals (xs) = List.filter (fn x => Char.isUpper (String.sub (x, 0))) xs

fun longest_string1 (xs) = List.foldl (fn (x, y) => if String.size(x) > String.size(y) then x else y) "" xs

fun longest_string2 (xs) = List.foldl (fn (x, y) => if String.size(x) >= String.size(y) then x else y) "" xs

fun longest_string_helper g xs = List.foldl (fn (x, y) => if g(String.size(x),String.size(y)) then x else y) "" xs

val longest_string3 = longest_string_helper (fn (x, y) => x > y)

val longest_string4 = longest_string_helper (fn (x, y) => x >= y)
				     
fun longest_capitalized (xs) = (longest_string1 o only_capitals) xs 

fun rev_string (xs) = (String.implode o List.rev o String.explode) xs

fun first_answer f xs =
    case xs of
	[] => raise NoAnswer
      | x :: xs' =>
	case f x of
	    NONE => first_answer f xs'
	 | SOME v => v 

fun all_answers f xs =
    let
	fun helper g ys =
	    case ys of
		[] => ([], false)
	      | y :: ys' =>
		case (g y, helper g ys') of
		    (NONE, _) => ([] , true)
		  | (_, (_, true)) => ([], true)
		  | (SOME v, (ls, false)) => (v @ ls, false)
	val (new_list, any_none) = helper f xs
    in
	if any_none then NONE else SOME new_list
    end
	
val count_wildcards = g (fn x => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn x => 1) (fn s => String.size(s))

fun count_some_var (s, p) = g (fn x => 0) (fn y => if s = y then 1 else 0) p

fun check_pat (p) =
    let
	fun get_variables (p) =
	    case p of
	        Variable x => [x]
	      | TupleP ps  => List.foldl (fn (p, ls) => get_variables(p) @ ls) [] ps  
	      | ConstructorP(_,p) => get_variables (p)
	      | _ => []

	fun has_duplication (xs) =
	    case xs of
		[] => false
	      | x :: xs' => List.exists (fn y => if x = y then true else false) xs' orelse has_duplication (xs') 
	
    in
	not (has_duplication (get_variables (p)))
    end

fun match (v, p) =
    case (v, p) of
	(_, Wildcard) => SOME []
      | (v, UnitP) => if v = Unit then SOME [] else NONE
      | (v, Variable x) => SOME [(x,v)]
      | (Const y, ConstP x) => if x = y then SOME [] else NONE
      | (Tuple ys, TupleP xs) => if List.length(ys) = List.length(xs)
				 then all_answers (fn (y, x) => match(y, x)) (ListPair.zip (ys, xs))
				 else NONE
      | (Constructor (st, y), ConstructorP (sp, x)) => if sp = st then match(y, x) else NONE
      | (_, _) => NONE
							      
fun first_match v pls =
    (case first_answer (fn x => match(v, x)) pls of
	 v => SOME v)
    handle
    NoAnswer => NONE
	    
