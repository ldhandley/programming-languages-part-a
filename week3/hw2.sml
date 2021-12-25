(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option (s, lst) =
  let 
    fun helper (s,lst,ret) =
      case lst of
        [] => NONE
       | hd::tl => if same_string(hd,s) then SOME (ret @ tl) else
         helper(s,tl,ret@[hd])
  in
    helper(s,lst,[])
  end

(* Whoops! I guess it wasn't supposed to be tail recursive for this one? *)
fun get_substitutions1 (lists,s) = 
  let 
    fun helper (lists,s,ret) =
      case lists of
          [] => ret
         |hd::tl => 
             case all_except_option(s,hd) of
                 NONE => helper(tl,s,ret)
                |SOME lst => helper(tl,s,ret @ lst)
  in
    helper(lists,s,[])
  end

fun get_substitutions2 (lists,s) = 
  let 
    fun helper (lists,s,ret) =
      case lists of
          [] => ret
         |hd::tl => 
             case all_except_option(s,hd) of
                 NONE => helper(tl,s,ret)
                |SOME lst => helper(tl,s,ret @ lst)
  in
    helper(lists,s,[])
  end

fun similar_names (lists,full_name)=
  let
    fun get_list_of_all_names(subs)=
      case subs of
           []=>[full_name]
         |hd::tl => case full_name of
                         {first=_,middle=m,last=l} =>
                         {first=hd,middle=m,last=l}::get_list_of_all_names(tl)
  in
    case full_name of
         {first=f,middle=m,last=l} =>
         get_list_of_all_names(get_substitutions2(lists,f))
  end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

fun card_color (suit,rank)=
  case suit of
       Clubs => Black
       |Diamonds => Red
       |Hearts => Red
       |Spades => Black

fun card_value (suit, rank)=
  case rank of
       Ace =>11
     |King=>10
     |Queen=>10
     |Jack=>10
     |Num i=>i


fun remove_card(card_list, c, e) = 
  let
    fun helper(card_list,acc) =
      case card_list of
        [] => raise e
        |hd::tl => if c=hd then acc@tl else helper(tl,hd::acc) 
  in
    helper(card_list,[])
  end

fun all_same_color (card_list) = 
  case card_list of
    [] => true
     |_::[] => true
     |hd::(neck::rest) => card_color(hd)=card_color(neck) andalso all_same_color(neck::rest)

fun sum_cards (card_list) =
  let
    fun helper (card_list,acc) =
      case card_list of
           [] => acc
         |hd::tl => helper(tl,acc+card_value(hd))
  in
    helper(card_list,0)
  end

fun score (held_cards, goal) = 
  let
    val sum = sum_cards(held_cards)
    val prelim_score = if sum > goal then 3*(sum-goal) else goal-sum
  in
    if all_same_color(held_cards)
    then (prelim_score div 2)
    else prelim_score
  end

fun officiate (card_list, move_list, goal) = 
  let
    fun helper (held_cards,card_list,move_list) = 
     case move_list of
        [] => score(held_cards,goal)
        |hd::tl => case hd of
                        Discard c =>
                        helper(remove_card(card_list,c,IllegalMove),card_list,tl)
                      |Draw => case card_list of
                      [] => score(held_cards,goal)
                      |hd2::tl2 => if sum_cards(hd2::held_cards)>goal 
                                  then score(hd2::held_cards,goal) 
                                  else
                                    helper(hd2::held_cards,
                                    remove_card(card_list,hd2,IllegalMove), tl) 
  in
    helper([],card_list,move_list)
  end


