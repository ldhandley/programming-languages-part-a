(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1 = all_except_option ("string", ["string"]) = SOME []
val test1a = all_except_option ("s", ["string"]) = NONE
val test1b = all_except_option ("str", ["apple","bera","str","blah"]) = SOME ["apple","bera","blah"]

val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test2a =
  get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff") = ["Jeffrey","Geoff","Jeffrey"]
val test2b = get_substitutions1([["Geoff","Jeff","Jeffrey"],["Lindsey","Lindz"]],"Jeff") = ["Geoff","Jeffrey"] 

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []

(* Reorganized result to get this to pass*)
val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) 
	    =[{first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith",
       middle="W"},{first="Fred", last="Smith", middle="W"} ]
       

val test5 = card_color (Clubs, Num 2) = Black
val test5a = card_color (Hearts, Num 2) = Red

val test6 = card_value (Clubs, Num 2) = 2
val test6a = card_value (Clubs, Ace) = 11
val test6b = card_value (Hearts, Jack) = 10

val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
(*val test7a = remove_card ([(Hearts, Ace)], (Spades, Ace), IllegalMove)*)
val test7b = remove_card ([(Clubs,Queen),(Hearts, Ace),(Diamonds,Num 9)],
(Hearts, Ace), IllegalMove) = [(Clubs,Queen),(Diamonds,Num 9)]



val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test8a = all_same_color [(Hearts, Num 2), (Hearts, Ace),(Spades,Queen)] =
  false
val test8b = all_same_color [(Clubs, Num 2), (Spades, Ace),(Spades,Queen)] =
  true

val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test9a = sum_cards [(Clubs, Queen),(Clubs, Num 2)] = 12

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4


val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             
