(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "homework1.sml";

val test1 = is_older ((1,2,3),(2,3,4)) = true
val test1a = is_older ((2022,4,15),(2021,12,5)) = false
val test1b = is_older ((2021,1,22),(2021,2,10)) = true
val test1c = is_older ((2021,1,22),(2021,1,23)) = true
val test1d = is_older ((2022,12,15),(2022,12,5)) = false
val test1e = is_older ((2023,12,15),(2022,12,5)) = false

val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test2a = number_in_month ([(2012,2,28),(2013,2,1)],2) = 2
val test2b = number_in_month ([(2012,2,28),(2013,2,1),(2014,2,30)],2) = 3
val test2c = number_in_month ([(2012,2,28),(2013,2,1),(2020,3,4),(2014,2,30)],2) = 3


val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test3a = number_in_months
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3]) = 2


val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test4a = dates_in_month ([(2012,2,28),(2013,12,1),(2020,2,12)],2) =
  [(2012,2,28),(2020,2,12)]

val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test5a = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3]) = [(2012,2,28),(2011,3,31)]

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test8a = number_before_reaching_sum (10, [1,2,7,4,5]) = 2

val test9 = what_month 70 = 3
val test9a = what_month 312 = 11

val test10 = month_range (31, 34) = [1,2,2,2]
val test10a = month_range (36, 34) = []


val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)

val test12 = number_in_months_challenge
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,2,3,3])  = 3 
val test12a = number_in_months_challenge
([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,3]) = 2 

val test13 = reasonable_date(2021,12,12) = true 
val test13a = reasonable_date(2021,2,29) = false
