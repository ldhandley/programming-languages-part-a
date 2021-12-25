(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* string * string list -> string list option *)
fun all_except_option(str, strs)=
    case strs of
       [] => NONE
     | other::others => if same_string(str, other)
                        then SOME others
                        else 
                            let val res = all_except_option(str, others)
                            in case res of
                               NONE => NONE
                             | SOME remaining => SOME (other::remaining)
                            end

(* string list list * string -> string list *)
fun get_substitutions1(substitutions, s)=
    case substitutions of
       [] => []
     | subs::rest => let val ops = all_except_option(s, subs)
                      in
                        case ops of
                           NONE => get_substitutions1(rest, s)
                         | SOME alternatives => alternatives@get_substitutions1(rest, s)
                      end

(* string list list * string -> string list *)
fun get_substitutions2(substitutions, s)=
    let
      fun helper(substitutions, s, acc)=
        case substitutions of
           [] => acc
         | subs::rest => let val ops = all_except_option(s, subs)
                         in
                           case ops of
                              NONE => helper(rest, s, acc)
                            | SOME alternatives => helper(rest, s, alternatives@acc)
                         end
        
    in
      helper(substitutions, s, [])
    end
(* string list list * {first:string, middle:string, last:string} -> {first:string, middle:string, last:string} list *)
fun similar_names(substitutions, full_name)=
    case full_name of
       {first=f_n, middle=m_n, last=l_n} => 
            let
                fun helper(alternatives)=
                    case alternatives of
                       [] => []
                     | other_fn::others => {first=other_fn, middle=m_n, last=l_n}::helper(others)
            in
                helper(f_n::get_substitutions1(substitutions, f_n))
            end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* card -> color*)
fun card_color(c)=
    case c of
       (Clubs, _) => Black
     | (Spades, _) => Black
     | _ => Red

(* card -> int *)
fun card_value(c)=
    case c of
       (_, Ace) => 11
     | (_, Num n) => n
     | _ => 10

(* card list * card * exp ->  card list *)
fun remove_card(cs, c, e)=
    case cs of
       [] => raise e
     | other::others => if c=other
                        then others
                        else other::remove_card(others, c, e)

(* card list -> bool *)
fun all_same_color(cs)=
    case cs of
       [] => true
     | _::[] => true
     | c1::c2::rest => card_color(c1)=card_color(c2) andalso all_same_color(c2::rest)

(* card list -> int *)
fun sum_cards(cs)=
    let
      fun helper(cs, acc)=
        case cs of
           [] => acc
         | c::rest => helper(rest, acc+card_value(c))
    in
      helper(cs, 0)
    end

(* card list * int -> int *)
fun score(cs, goal)=
    let
      val sum = sum_cards(cs)
      fun preliminary_score()=
        if sum > goal
        then 3*(sum-goal)
        else (goal-sum)
    in
      if all_same_color(cs)
      then preliminary_score() div 2
      else preliminary_score()
    end

(* card list * move list * int -> int *)
fun officiate(cs, mvs, goal)=
    let
      fun step(cs, hs, mvs)=
        case mvs of
           [] => score(hs, goal)
         | (Discard c)::mvs' => step(cs, remove_card(hs, c, IllegalMove), mvs')
         | (Draw)::mvs' => case cs of
                              [] => score(hs, goal)
                            | c::cs' => if sum_cards(c::hs)>goal
                                        then score(c::hs, goal)
                                        else step(cs', c::hs, mvs')
    in
      step(cs, [], mvs)
    end

(* card list * int -> int *)
fun score_challenge(cs, goal)=
    let

      val same_color = all_same_color(cs)

      fun count_aces(cs)=
        case cs of
           [] => 0
         | (_, Ace)::cs' => 1+count_aces(cs')
         | _::cs' => count_aces(cs')

      fun other_sums_with_aces(initial_sum, num_aces)=
        if num_aces>0
        then (initial_sum-10)::other_sums_with_aces(initial_sum-10, num_aces-1)
        else []
    
      val sum = sum_cards(cs)
      
      (* int list with all possible values of the current hand due to ace value variation *)
      (* These values are ALWAYS in descending order *)
      val sums = sum::other_sums_with_aces(sum, count_aces(cs))

      fun preliminary_score(sum)=
        if sum > goal
        then 3*(sum-goal)
        else (goal-sum)
      
      fun single_score(sum)=
        if same_color
        then preliminary_score(sum) div 2
        else preliminary_score(sum)
    
      fun final_scores(sums)=
        case sums of
           s::[] => single_score(s)::[]
         | s::s' => single_score(s)::final_scores(s')
         | [] => [] (* Unreachable, only to avoid warning*)
    
      fun get_best_score(scores)=
        case scores of
           s::[] => s
         | s1::s2::s' => if s1<s2
                         then get_best_score(s1::s')
                         else get_best_score(s2::s')
         | [] => ~10 (* Unreachable, only to avoid warning*)
    in
      get_best_score(final_scores(sums))
    end

(* Copy-pasted Ace-related functions for local scope to avoid issues with extra bindings with auto-grader *)
fun officiate_challenge(cs, mvs, goal)=
    let
      fun count_aces(cs)=
        case cs of
           [] => 0
         | (_, Ace)::cs' => 1+count_aces(cs')
         | _::cs' => count_aces(cs')

      fun other_sums_with_aces(initial_sum, num_aces)=
        if num_aces>0
        then (initial_sum-10)::other_sums_with_aces(initial_sum-10, num_aces-1)
        else []
    
      

      fun all_sums_greater_than_goal_from_cards(cs)=
        let
          val sum = sum_cards(cs)
          (* int list with all possible values of the current hand due to ace value variation *)
          (* These values are ALWAYS in descending order *)
          val sums = sum::other_sums_with_aces(sum, count_aces(cs))

          fun helper(sums)=
            case sums of
               s::[] => s>goal
             | s::s' => s>goal andalso helper(s')
             | [] => false (* Unreachable, only to avoid warning*)
        in
          helper(sums)
        end


      fun step(cs, hs, mvs)=
        case mvs of
           [] => score_challenge(hs, goal)
         | (Discard c)::mvs' => step(cs, remove_card(hs, c, IllegalMove), mvs')
         | (Draw)::mvs' => case cs of
                              [] => score_challenge(hs, goal)
                            | c::cs' => if all_sums_greater_than_goal_from_cards(cs)
                                        then score_challenge(c::hs, goal)
                                        else step(cs', c::hs, mvs')
    in
      step(cs, [], mvs)
    end

(* card list * int -> move list *)
fun careful_player(cs, goal)=
    let
      fun is_zero_ahead(hs, c, num_rotations)=
        if num_rotations<=0
        then NONE
        else case hs of
                h::hs' => if score(c::hs', goal)=0
                          then SOME h
                          else is_zero_ahead(hs'@[h], c, num_rotations-1)
              | [] => NONE

      fun step(cs, hs)=
        if (10+sum_cards(hs))<goal
        then case cs of
                c::cs' => Draw::step(cs', c::hs)
              | [] => Draw::[] (* As per the requirements listed *)
        else if score(hs, goal)=0
        then []
        else case cs of
                c::cs' => case is_zero_ahead(hs, c, length hs) of
                             NONE => Draw::step(cs', c::hs) (* Draw as default if nothing else is possible *)
                           | SOME h => (Discard h)::Draw::[] (*No need to do another step, it will get score 0 and exit*)
    in
      step(cs, [])
    end
