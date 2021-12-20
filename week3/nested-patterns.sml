(* Patterns can be nested inside each other! As deep as we want! *)

(* Zip takes ([1,2,3],[4,5,6],[7,8,9])  and returns [(1,4,7),(2,5,8),(3,6,9)]*)

(* Unzip takes [(1,4,7),(2,5,8),(3,6,9)] and returns ([1,2,3],[4,5,6],[7,8,9]) *)

exception ListLengthMismatch
(* This is SO much cleaner than all the if then else blocks we had to use before *)
fun zip3 list_triple =
  case list_triple of
       ([],[],[]) => []
     | (hd1::tl1, hd2::tl2, h3::tl3) => (hd1,hd2,hd3)::zip3(tl1,tl2,tl3)
     | _ => raise ListLengthMismatch
(* If the lists are all empty, return an empty list *)
(* If the lists contain stuff, do the zip recursively until you cons onto empty *)
(* If there's any other situation (like one of the lists is empty), raise an
* exception *)

fun unzip3 lst =
  case lst of
       [] => ([],[],[])
     |(a,b,c)::tl => let val (l1,l2,l3) = unzip3 tl
                     in
                       (a::l1, b::l2, c::l3)
                     end
