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

(* 1. *)
val only_capitals = List.filter (Char.isUpper o (fn s => String.sub(s,0)))

(* 2. *)
fun longest_string1(string_list) = 
	foldl (fn (s1,s2) => if String.size s1 > String.size s2 
							then s1 
							else s2) 
							"" string_list

(* 3. *)
fun longest_string2(string_list) = 
	foldl (fn (s1,s2) => if String.size s1 >= String.size s2 
							then s1 
							else s2) 
							"" string_list

fun longest_string_helper(greater_than) = 
	foldl (fn (s1,s2) => if greater_than(String.size(s1),String.size(s2)) 
							then s1 
							else s2) 
							""
(* 4.a *)
val longest_string3 = longest_string_helper (fn (lhs,rhs) => lhs > rhs)

(* 4.b *)
val longest_string4 = longest_string_helper (fn (lhs,rhs) => lhs >= rhs)

(* 5. *)
val longest_capitalized = longest_string1 o only_capitals

(* 6. *)
val rev_string = String.implode o rev o String.explode 

(* 7. *)
fun first_answer f list =
	case list of
	   [] => raise NoAnswer
	 | x::xs => case f x of	
				   SOME(v) => v
		  		 | NONE => first_answer f xs

(* 8. *)
fun all_answers f list =
	let fun helper(list, acc) = 
		case list of
		   [] => SOME acc
		 | x::xs => 
		 	case f x of
				NONE => NONE
			  | SOME l => helper(xs, acc @ l)
	in 	
		helper(list,[])	
	end

(* 9.a. *)
val count_wildcards = g (fn() => 1) (fn _ => 0)


(* 9.b. *)
val count_wild_and_variable_lengths = g (fn() => 1) (fn s => String.size s)


(* 9.c. *)
fun count_some_var (s,p) = g (fn() => 0) (fn s1 => if s = s1 then 1 else 0) p


(* 10. *)
fun check_pat(pat) = 
	let fun get_var_names(pat) = 
		case pat of
		Variable(s) => [s]
		| TupleP(p::ps) =>  foldl (fn (p1,s2) => (get_var_names(p1) @ s2))  (get_var_names(p)) ps 
		| ConstructorP(_,pt) => get_var_names(pt) 
		| _ => []
		fun no_reps(str_lst) = 
			case str_lst of
			[] => true
			| s::ss => (not (List.exists (fn(x) => x = s ) ss)) andalso no_reps(ss)
		val names = get_var_names(pat)
	in
		no_reps(names)
	end

(* 11. *)
(* Note for graders: *)
(* 	In the branch for tuples I use ListPair.zipEq instead of ListPair.zip. *)
(* 	This function raises exception if the provided lists aren't equal, thus removes the need to check for length, *)
(* 	and more importantly, does the job in one traversal *)
(* 	See documentation here: https://smlfamily.github.io/Basis/list-pair.html#ListPair:STR:SPEC *)
fun match(vl, pat) = 
	case (vl, pat) of
	   (v, Wildcard) => SOME []
	 | (v, Variable(s)) => SOME([(s,v)])
	 | (Unit,UnitP) => SOME []
	 | (Const(i),ConstP(j)) => if i = j then SOME [] else NONE
	 | (Constructor(s1,v),ConstructorP(s2,p)) => if s1 = s2 then match(v,p) else NONE
	 | (Tuple(vs),TupleP(pts)) => ((all_answers match (ListPair.zipEq (vs, pts))) 
	 								handle UnequalLengths => NONE )
	 | _ => NONE

(* 12. *)
fun first_match(v, pats) = 
	SOME(first_answer (fn p => match(v,p)) pats) handle NoAnswer => NONE


(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
