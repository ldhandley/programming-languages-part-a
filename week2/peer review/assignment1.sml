fun is_older (t1 : (int*int*int), t2 : (int*int*int)) =
    if (#1 t1) < (#1 t2)
    then true
    else if (#1 t1) > (#1 t2)
    then false
    else
	if (#2 t1) < (#2 t2)
	then true
	else if (#2 t1) > (#2 t2)
	then false
	else
	    if (#3 t1) < (#3 t2)
	    then true
	    else if (#3 t1) > (#3 t2)
	    then false
	    else false

val test1 = is_older ((1,2,3),(2,3,4)) = true
		     
fun number_in_month (ls : (int*int*int) list, m : int) =
    if null ls
    then 0
    else
	if (#2 (hd ls)) = m
	then 1 + number_in_month ((tl ls), m)
	else
	    number_in_month ((tl ls), m)

val test2 = number_in_month ([(2012,2,28),(25,2,28),(2017,2,28),(2012,2,28),(2018,2,28),(2013,12,1)],2) = 5					     

													      
fun number_in_months (lsd : (int*int*int) list, lsm : int list) =
    if null lsm
    then 0
    else number_in_month (lsd, (hd lsm)) +  number_in_months (lsd, (tl lsm))
		
val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2013,2,1),(2011,4,28)],[2,3,4]) = 4;

fun dates_in_month (lsd : (int*int*int) list, m : int) =
    if null lsd
    then []
    else
	if (#2 (hd lsd)) = m
	then (hd lsd) :: (dates_in_month ((tl lsd), m))
	else dates_in_month ((tl lsd), m)

val test4 = dates_in_month ([(2012,2,28),(2012,2,28),(2012,2,28),(2013,12,1)],2) = [(2012,2,28),(2012,2,28),(2012,2,28)]    

fun dates_in_months (lsd : (int*int*int) list, lsm : int list) =
    if null lsm
    then []
    else
	dates_in_month (lsd, (hd lsm)) @ dates_in_months (lsd, (tl lsm))


val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

										       
fun get_nth (lss : string list, n : int) =
    if n =1
    then (hd lss)
    else
	get_nth((tl lss), n-1)

val test6 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi"	  
	
fun date_to_string (d : (int*int*int)) =
    let val L = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
	(get_nth(L, (#2 d)))^(" ")^(Int.toString (#3 d))^(", ")^(Int.toString (#1 d))
    end
	
val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

fun number_before_reaching_sum (sum : int, lsi : int list) =
    let fun local_fun (sum, lsi, acc) =
	    if sum-(hd lsi) <= 0
	    then acc
	    else
		local_fun((sum-(hd lsi)), (tl lsi), acc+1)
    in
	local_fun(sum, lsi, 0)
    end
	
val test8 = number_before_reaching_sum (10, [1,9,3,4,5]) = 1


fun what_month (d : int) =
    let
	val day_month = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
	number_before_reaching_sum(d, day_month) + 1
    end
	
val test9 = what_month 70 = 3


fun month_range (d1 : int, d2 : int) =
    let
	fun local_fn (m1 : int, m2 : int)=
	    if m1 > m2
	    then []
	    else
		what_month(m1) :: (local_fn (m1+1,m2))
    in
	local_fn(d1, d2)
    end
	
val test10 = month_range (31, 34) = [1,2,2,2]
	
			   
fun oldest (lsd : (int*int*int) list) =
    if null lsd
    then NONE
    else
	let
	    fun local_fn (lsd : (int*int*int) list) =
		if null (tl lsd)
		then (hd lsd)
		else
		    let val tl_ans =  local_fn(tl lsd)
		    in
			if is_older((hd lsd), tl_ans)
			then hd lsd
			else tl_ans
		    end
	in
	    SOME (local_fn lsd)
	end
	    
val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)	    

fun in_list (n : int, lsi: int list) =
    if null lsi
    then false
    else
	if n = hd lsi
	then true
	else
	    in_list(n, tl lsi)
		
val test12_1 = in_list(3, [1,2,3]) = true								  

fun remove_duplicates (lsi : int list) =
    let
	fun local_fn (lsi1 : int list, lsi2 : int list)=
	    if null lsi1
	    then []
	    else
		if in_list((hd lsi1), lsi2)
		then local_fn(tl lsi1, lsi2)
		else
		    hd lsi1 :: local_fn(tl lsi1, (hd lsi1)::lsi2)
    in
	local_fn (lsi, [])
    end
	
val test12_2 = remove_duplicates([1,2,2,3,3,4]) = [1,2,3,4]		
			
val test12_2_1 = remove_duplicates([2,4,2,1,2,5,7,3,5,7,9,7,8,6,4,7,2,4,2,5,0])
               = [2,4,1,5,7,3,9,8,6,0]		    
    
fun number_in_months_challenge (lsd : (int*int*int) list, lsm : int list) =
    let
	val lsm_rd = remove_duplicates(lsm)
    in
	number_in_months(lsd, lsm_rd)
    end
	
val test12_3 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31)
                                           ,(2011,4,28)],[2,3,4,2,3])
               = 3
fun dates_in_months_challenge (lsd : (int*int*int) list, lsm : int list)=
    let
	val lsm_rd = remove_duplicates(lsm)
    in
	dates_in_months(lsd, lsm_rd)
    end

val test12_4 = dates_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31)
                                          ,(2011,4,28)],[2,3,4,2,3])
               = [(2012,2,28),(2011,3,31),(2011,4,28)]


fun is_leap(d : (int*int*int)) =
    if ((#1 d) mod 400)=0  orelse ((#1 d) mod 4)=0
    then
	if not ((#1 d) mod 100 = 0)
	then true
	else false
    else false
	     
val test13_1 = is_leap((2000,5,23)) = false
		     
fun is_real_data (d : (int*int*int)) =
    if (#2 d) = 1 orelse (#2 d) = 3 orelse (#2 d) = 5 orelse (#2 d) = 7 orelse (#2 d) = 8 orelse (#2 d) = 10 orelse (#2 d) = 12
    then if (#3 d) > 31 orelse (#3 d) < 1
	 then false
	 else true
    else if not ((#2 d)=2)
    then if (#3 d)>30 orelse (#3 d)<1
	 then false
	 else true
    else
	if is_leap(d)
	then if (#3 d)>29 orelse (#3 d)<1
	     then false
	     else true
	else
	    if (#3 d)>28 orelse (#3 d)<1
	    then false
	    else true
	    	

		     
fun reasonable_date (d : (int*int*int)) =
    if (#1 d)<=0 orelse (#2 d)<1 orelse (#2 d)>12
    then false
    else
	if is_real_data(d)
	then true
	else false
		 
val test13_3 = not (reasonable_date((0,2,28))) andalso
             not (reasonable_date((2016,13,28))) andalso
             not (reasonable_date((2016,2,40))) andalso
             reasonable_date((2016,1,1)) andalso
             reasonable_date((2016,12,31)) andalso
             reasonable_date((2016,2,29))
