val empty = []

(* list can have any length*)
val list1 = [3,4,5]
(* everything in list must be same type *)
val list2 = [true, false, false]  

(* you can cons an item of the appropriate type onto a list with :: *)
(* the item to add comes first, the list to add it to comes 2nd *)
val cons1 = 1::list1

val cons2 = 5::cons1

val cons_nested = [6]::[[7,5],[5,2]]

(* null returns true if a list is empty, false otherwise *)
val check = null []

(* gets the head of a list *)
val head = hd cons2

(* gets the tail of a list *)
val tail = tl cons2

val tails_of_tails = tl(tl (tl cons2))
val tails_of_tails2 = tl(tl (tl (tl cons2)))
val tails_of_tails3 = tl(tl (tl (tl (tl cons2)))) (* you get empty list *)
(* if you tailed past an empty list though, you raise an exception *)


