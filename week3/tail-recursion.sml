(* Call stack: while a program runs, the call stack is the list of all functions
* that haven't finished running yet *)
  (* Calling a function f pushes an instance of f onto the stack *)
  (* When a call to f finishes, it is popped from the stack *)
(* Due to recursion, multiple stack-frames may be calls to the same function *)

(* Tail recursion avoids growing the stack though! If you can make it so that
* the recursion doesn't have to do anymore work, it will replace the stackframe
* for the previous call, so there's only every one thing in the stack (which
* will return the accumulated answer when it reaches the end)  *)

fun fact n = 
  let fun aux(n,acc) =
    if n=0
    then acc
    else aux(n-1,acc*n)
  in
    aux(n,1)
  end

val x = fact 3
