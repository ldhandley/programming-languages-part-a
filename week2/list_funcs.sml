fun sum_list (xs : int list) =
  if null xs
  then 0
  else hd xs + sum_list(tl xs)

fun list_prod (xs : int list) =
  if null xs
  then 1
  else hd xs * list_prod(tl xs)

fun countdown(x:int) = (* [7,6,5,4,3,2,1] *)
  if x=0
  then []
  else x :: countdown(x -1)

fun append (xs : int list, ys : int list) = 
  if null xs
  then ys
  else (hd xs) :: append((tl xs), ys)

fun firsts (xs: (int * int) list) =
  if null xs
  then []
  else (#1 (hd xs))::firsts(tl xs)

fun seconds (xs: (int * int) list) =
  if null xs
  then []
  else (#1 (hd xs))::seconds(tl xs)

fun sum_pair_list2 (xs : (int * int) list) =
  (sum_list(firsts xs)) + (sum_list(seconds xs))

fun factorial (n:int) =
  if n = 0
  then 1
  else n*factorial(n-1)

fun factorial2 (n:int) = 
  if n = 0
  then 1
  else list_prod(countdown(n))
