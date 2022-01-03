fun n_times (f,n,x) = 
  if n=0
  then x
  else f (n_times(f,n-1,x))

fun triple_n_times(n,x) =
  let
    fun triple x = 3*x
  in
    n_times(triple,n,x)
  end
(*Better style than having triple defined outside*)

fun triple_n_times(n,x) =
    n_times(let fun triple x = 3*x in triple end,n,x)
(*Better since it's EXACTLY where I need it... but there's an even better way*)

fun triple_n_times(n,x) =
    n_times((fn x => 3*x), n, x)
(* Anonymous functions! Instead of fun, use fn. Instead of = use => *)
(* Function bindings (fun name (x) = ... ) are not expressions. Need an
* expression as an argument to a function. *)
