(* Define local variables between let and in *)
(* These local variables only apply to body of let (between in and end) *)

fun silly2()=
let
  val x = 1
in
  (let val x = 2 in x+1 end) + (let val y = x+2 in y+1 end)
end
