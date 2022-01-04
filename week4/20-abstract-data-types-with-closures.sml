datatype set = s of { insert : int -> set,
                      member : int -> bool,
                      size : unit -> int}

val empty_set = 
  let 
    fun make_set xs =
      let
        fun contains i = List.exists (fn j => i=j) xs
      in
        s {insert = fn i=> if contains i
                           then make_set xs
                           else make_set (i::xs),
           member = contains,
           size   = fn () => length xs }
      end
   in
     make_set []
  end

fun use_sets () =
  let val s s1 = empty_set
      val s s2 = (#insert s1) 34
      val s s3 = (#insert s2) 34
      val s s4 = #insert s3 19
  in
    if (#member s4) 42
    then 99
    else if (#member s4) 19
    then 17 + (#size s3) ()
    else 0
  end
(* returns 19 *)


