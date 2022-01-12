(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]
val test1a = only_capitals ["Apple","Boy","Card"] = ["Apple","Boy","Card"]
val test1b = only_capitals ["apple","Boy","Card"] = ["Boy","Card"]
val test1c = only_capitals ["apple","boy","card"] = []
val test2 = longest_string1 ["A","bc","C"] = "bc"
val test2a = longest_string1 [] = ""
val test2b = longest_string1 ["Pizza","House","Dog"] = "Pizza"
val test2c = longest_string1 ["A","bc","C","dDe"] = "dDe"
val test3 = longest_string2 ["A","bc","C"] = "bc"
val test4a = longest_string3 ["A","bc","C"] = "bc"
val test4a2 = longest_string3 ["Aa","bc","C"] = "Aa"
val test4b = longest_string4 ["A","B","C"] = "C"
val test4b2 = longest_string4 ["Aa","bc","C"] = "bc"
val test5 = longest_capitalized ["A","bc","C"] = "A"
val test5a = longest_capitalized ["a","Bc","C"] = "Bc"
val test6 = rev_string "abc" = "cba"
val test6a = rev_string "Kitty" = "yttiK"
val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
(*val test7a = first_answer (fn x => if x > 5 then SOME x else NONE) [1,2,3,4,5]
* *)
val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8a = all_answers (fn x => if x > 1 then SOME [x] else NONE)
[2,3,4,5,6,7] = SOME [2, 3, 4, 5, 6, 7]
val test8b = all_answers (fn x => if x > 1 then SOME [x] else NONE)
[] = SOME []
val test9a = count_wildcards Wildcard = 1
val test9a2 = count_wildcards (ConstructorP ("c1", Variable "c1")) = 0
val test9b = count_wild_and_variable_lengths (Variable("a")) = 1
val test9b2 = count_wild_and_variable_lengths (TupleP [Variable "a", Wildcard,
Variable "c0", ConstructorP ("c1", Variable "c1")]) = 6 
val test9c = count_some_var ("x", Variable("x")) = 1
val test9c2 = count_some_var ("c0", (TupleP [Variable "c0", Wildcard,
Variable "c0", ConstructorP ("c1", Variable "c0")])) = 3
val test10 = check_pat (Variable("x")) = true
val test10a = check_pat (TupleP [Variable "a", Wildcard, Variable "c0",
ConstructorP ("c1", Variable "c1")]) = true 
val test10b = check_pat (TupleP [Variable "c1", Wildcard, Variable "c0",
ConstructorP ("c1", Variable "c1")]) = false 

val test11 = match (Const(1), UnitP) = NONE
val test11a = match (Tuple [Const 3, Unit, Constructor ("c0", Const 3), Constructor ("c1", Const 3)], TupleP [Variable "a", Wildcard, Variable "c0", ConstructorP ("c1", Variable "c1")]) = SOME [("c1",Const 3),("c0",Constructor ("c0",Const 3)),("a",Const 3)]
(*

val test12 = first_match Unit [UnitP] = SOME []
*)
