fun is_older (date1: int*int*int, date2: int*int*int) =
  let
    val year1 = (#1 date1)
    val year2 = (#1 date2)
    val month1 = (#2 date1)
    val month2 = (#2 date2)
    val day1 = (#3 date1)
    val day2 = (#3 date2)
    fun years_equal () =
      year1 = year2
    fun months_equal () =
      month1 = month2
    fun days_equal () =
      day1 = day2
  in
    if years_equal() 
    then 
      if months_equal()
      then day2 > day1 
      else month2 > month1
    else year2 > year1
  end

fun number_in_month (dates: (int*int*int) list , month: int) = 
  let
    fun right_month (date: int*int*int) =
      (#2 date) = month
  in
    if null dates
    then 0
    else 
      if right_month(hd dates)
      then 1 + number_in_month(tl dates, month)
      else 0 + number_in_month(tl dates, month)
  end

fun number_in_months (dates: (int*int*int) list, months: int list) =
  if null months
  then 0
  else number_in_month(dates, (hd months)) + number_in_months(dates, (tl months))

fun dates_in_month (dates: (int*int*int) list,month:int) = 
  if null dates
  then []
  else 
    if month = (#2 (hd dates))
    then (hd dates) :: dates_in_month((tl dates), month)
    else dates_in_month((tl dates), month)

fun dates_in_months (dates: (int*int*int) list, months:int list) = 
  if null months
  then []
  else dates_in_month(dates, (hd months)) @ dates_in_months(dates, (tl months))

fun get_nth (strings: string list, n: int) = 
  if n=1
  then (hd strings)
  else get_nth(tl strings, n-1)

fun date_to_string (date: int*int*int) =
  let
    val months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
  in
    get_nth(months,(#2 date)) ^ " " ^ Int.toString(#3 date) ^ ", "^ Int.toString(#1 date)  
  end


fun number_before_reaching_sum (sum: int, nums: int list) =
  if (sum - (hd nums)) <= 0
  then 0
  else 1 + number_before_reaching_sum((sum - (hd nums)), (tl nums))

fun what_month (day:int) = 
let
  val days_in_each_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  fun find_month (day:int, days_in_each_month: int list) =
    if day - (hd days_in_each_month) <= 0
    then 1
    else 1 + find_month(day - (hd days_in_each_month), (tl days_in_each_month))
  in
    find_month(day, days_in_each_month)
  end

fun month_range (day1:int, day2:int) =
  if day1 > day2
  then []
  else what_month(day1) :: month_range(day1+1, day2)

fun oldest (dates:(int*int*int) list) = 
  if null dates
  then NONE
  else 
    let
      val tl_ans = oldest(tl dates)
    in
      if isSome tl_ans andalso is_older(valOf tl_ans, (hd dates))
      then tl_ans
      else SOME (hd dates)
    end

fun number_in_months_challenge (dates:(int*int*int) list, months:int list) =
  let
    fun create_unique_months (months: int list) =
      let
        fun is_repeated (month: int, months:int list) =
          if null months
          then false
          else
            if month = (hd months)
            then true
            else is_repeated(month, (tl months))
      in
        if null months
        then []
        else 
          if is_repeated ((hd months), (tl months))
          then create_unique_months(tl months)
          else (hd months) :: create_unique_months(tl months)
      end
  in
    number_in_months(dates, create_unique_months (months))
  end

fun reasonable_date (date: int*int*int) =
  let
    fun get_nth (ints: int list, n: int) = 
      if n=1
      then (hd ints)
      else get_nth(tl ints, n-1)
    val days_in_each_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    val days_in_each_month_leap_year = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    val year_positive = (#1 date) > 0
    val month_viable = 
      (#2 date) <= 12 andalso (#2 date) >= 1
    fun day_viable()=
      if (not ((#1 date mod 100) = 0)) andalso ((#1 date mod 400) = 0 orelse (#1 date mod 4) = 0)
      then 
        let
          val max = get_nth(days_in_each_month_leap_year, (#2 date))
          in
            (#3 date) <= max andalso (#3 date) >= 1
          end
      else 
        let
          val max = get_nth(days_in_each_month, (#2 date))
          in
            (#3 date) <= max andalso (#3 date) >= 1
          end
  in
    year_positive andalso month_viable andalso day_viable()
  end
