
(* 1. Using the following datatype declaration: *)

(* Write the function eval: expr -> int which evaluates an expression to a value. NUM(x) simply evaluates to x. 
PLUS, MINUS, TIMES, and DIV should recursively evaluate their sub-expressions, 
then perform the appropriate math operations. 
F exprs should recursively evaluate all the exprs in their expr list, 
then apply their function to the resulting integers. 
(Hint: You should use map in your F case.) *)

datatype expr =
         NUM of int
       | PLUS of expr * expr
       | MINUS of expr * expr
       | TIMES of expr * expr
       | DIV of expr * expr
       | F of expr list * (int list -> int)

fun eval (NUM x) = x
    | eval (PLUS (x,y)) = eval x +  eval y
    | eval (MINUS (x,y)) = eval x -  eval y
    | eval (TIMES (x,y)) = eval x * eval y
    | eval (DIV (x,y)) = eval x div eval y
    | eval (F (exprList, customFunc)) = customFunc (map eval exprList);
    
(* Test cases *)
val test1 = eval (NUM 5) = 5;
val test2 = eval (PLUS (NUM 3, NUM 4)) = 7;
val test3 = eval (MINUS (NUM 10, NUM 6)) = 4;
val test4 = eval (TIMES (NUM 2, NUM 3)) = 6;
val test5 = eval (DIV (NUM 8, NUM 2)) = 4;
val test6 = eval (PLUS (TIMES (NUM 2, NUM 3), NUM 4)) = 10;
val test7 = eval (MINUS (NUM 10, PLUS (NUM 3, NUM 2))) = 5;
val test8 = eval (F ([NUM 1, NUM 2, NUM 3], fn xs => foldl (op +) 0 xs)) = 6;
val test9 = eval (F ([NUM 2, NUM 3, NUM 4], fn xs => foldl (op *) 1 xs)) = 24;


(* 2. Use fold to write the flatten: ’a list list -> ’a list function. 
The flatten function merges together a list of lists into a single list with 
all of the elements in their original order. 
For example: flatten [[1,2,3], [4], [5,6], [], [7]] should result in the list [1,2,3,4,5,6,7]. *)

(* create function to append to list, pass into foldl *)

fun flatten listArr =
    let 
        fun joinLists ([], []) = []
            | joinLists ([], l2) = l2
            | joinLists (item::l1, l2) = item :: joinLists (l1,l2)
    in 
        foldr joinLists [] listArr
    end;


(* 3. Use fold to implement your own version of map. *)

(* apply a function to all items in list *)

fun foldMap customFunc itemList = 
    (* fold funcToApply Acc ListToAppl *)
    let 
        fun funcPrepend (item, acc) = 
            (customFunc item) :: acc

    in 
        foldr funcPrepend [] itemList
    end;

foldMap (fn x => x * 2) [1,2,3];

(*4. Use fold to implement your own version of filter. *)

fun foldFilter filtFunc itemList = 
    let 
        fun funcMyFilter (item, acc) = 
            if filtFunc item then item::acc
            else acc
    in 
        foldr funcMyFilter [] itemList
    end;

foldFilter (fn x => x > 2) [1,2,3,4,5];
foldFilter (fn x => x mod 2 = 0) [1,2,3,4,5];

(* 5. Use fold to write the function count: (’a -> bool) -> ’a list -> int 
    which returns a count of how many items in the list the ’a -> bool function returned true for. *)

fun count boolFunc itemList = 
    let 
        fun helper (item, acc) = 
            if boolFunc item then acc + 1
            else acc
    in
        foldl helper 0 itemList
    end;

count (fn x => x > 3) [1,2,3,4,5,6];
count (fn x => x mod 2 = 0) [1,2,3,4,5,6,8];

(* Use fold to write mapPartial: (’a -> ’b option) -> ’a list -> ’b list 
    this function is like a combination of map and filter. 
    For each item of the input list, if the function applied to that item returns SOME(b), 
    then b appears in the output list. 
    If NONE is returned, that item is dropped from the output list. *)

fun mapPartial partialFilterFunc itemList = 
    let
        fun helper (item, acc) = 
            case partialFilterFunc item of
                SOME x => x :: acc
                | NONE => acc
    in 
        foldr helper [] itemList
    end;

val isEven = fn x => if x mod 2 = 0 then SOME x else NONE;
mapPartial isEven [1,2,3,4,5,6];

val positiveOnly = fn x => if x > 0 then SOME x else NONE;
mapPartial positiveOnly [~1,1,~2,2,0,3];