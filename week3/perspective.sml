(* Sometimes can't make a recursive function tail-recursive *)
(* Functions that process trees for example: you almost never want to pass
* around an accumulator *)
(* Normal recursion is often more concise. Sometimes this is preferrable. *)
(* What is tail-call? *)
  (* If the result of f x is the immediate result for the enclosing function
  * body, then f x is a tail call! *)
