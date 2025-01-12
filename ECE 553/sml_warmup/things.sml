fun add3(x) = x + 3;

fun fact_tail t = case t of
                   (0,ans) => ans
                 | (x,ans) => fact_tail (x-1, ans * x);

(* another way to represent tail recursion, more brief *)

fun fact_tail (0, ans) = ans
    | fact_tail (x, ans) = fact_tail (x-1, ans * x);



(* let statements, for the scope of the in statement *)
fun fact x =
    let fun help (0,ans) = ans
          | help (x,ans) = help(x-1, x * ans)
    in
        help(x,1)
    end;


(* typing for records *)
type myRec = {x:string,
              y:int,
              z:bool,
              a:int,
              b:int,
              c:int};

fun f ({z=false,...}:myRec) = 0
  | f {a,y, ...} = a + y;


(* list stuff *)

fun f x =
  let val a = x * 2
      val b = x * 3 
  in
     [0, x, a, b, x * 4]
  end;

fun f [] = 0
    | f [a] = a+1 
    | f [a,b] = a*b
    | f (a::l) = a + f l;


(* passing functions *)
(* sorting list with arbitrary comp func *)

fun max gt [] = NONE
  | max gt (a::l) =
    let fun lp curr [] = curr
          | lp curr (a::l) = if gt(a,curr)
            then lp a l
            else lp curr l
in
  SOME(lp a l)
end


(* fold *)

(* Define a named function *)
fun myFunc (x, acc) = x + acc

(* Use it with foldl *)
val sumList1 = foldl myFunc 0 [1, 2, 3, 4, 5]

(* This is equivalent to the anonymous function version *)
val sumList2 = foldl (fn (x, acc) => x + acc) 0 [1, 2, 3, 4, 5]

(* Both sumList1 and sumList2 will be 15 *)


(* references *)

let 
    val r = ref 0
    val x = r
    (* val () = r := 47 *)
    val _ = r := 47
in
    !x 
end;