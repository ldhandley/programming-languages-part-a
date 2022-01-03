fun fold (f,acc,xs) = 
  case xs of
       [] => acc
     | x::xs => fold(f, f(acc,x), xs)

fun f1 xs = fold ((fn (x,y) => x+y), 0, xs)
(* sums list *)

fun f2 xs = fold ((fn (x,y) => x andalso y>=0), true, xs)
(* checks to see if all elements of list are greater than or equal to 0 *)

fun f3 (xs, lo, hi) =
  fold((fn (x,y) => 
            x + (if y >= lo andalso y<=hi then 1 else 0)),
        0, xs)
(* counts the number of list elements that are between lo and hi values *)

fun f4 (xs,s) = 
  let
    val i = String.size s
  in
    fold((fn (x,y) => x andalso String.size y < i), true, xs)
  end
(* checks to see if all strings in list are less than the size of string s *)

fun f5 (g,xs) = fold((fn(x,y)=> x andalso g y), true, xs)
(* do all elements of the list produce true when passed to g *)
(* can use this to redefine f4 *)

fun f4again (xs,s) =
  let
    val i = String.size s
  in
    f5(fn y => String.size y<i, xs)
  end
