(* 
Write the min function which 
has type int * int -> int and returns the smaller of its two arguments.
 *)

fun min (a, b) = 
    if a < b then
        a
    else
        b;

(* 
Write the fib function which has type int -> int and computes the nth Fibonacci number.
*)

fun fib n = 
    let 
        fun fib_helper (x,y,count) = 
            if count >= n then y
            else fib_helper(y, x+y, count+1);
    in
        if n <= 2 then 1
        else fib_helper(1,1,2)
    end;

(* Write the isPrime function which has type int -> bool and determines whether or not its
argument is prime. *)

fun isPrime num = 
    let 
        val maxCheckVal = num div 2;

        fun prime_checker (currCheckVal) = 
            if currCheckVal > maxCheckVal then true
            else if num mod currCheckVal <> 0 then prime_checker (currCheckVal + 1)
            else false;
    in 
        if num <= 1 then false
        else prime_checker(2)
    end;


(* 
Write the function sumList which has type int list ->int and 
computes the sum of all of the items in the list.
*)

fun sumList [] = 0
    | sumList (a::l) = a + sumList(l);


(* Write the function squareList which has type int list -> int list 
and returns a list of the same length as its argument, 
where each item in the returned list is the square of the corresponding 
item in the argument list. For example, squareList [2,5,1,3] should return
[4,25,1,9] *)

fun squareList [] = []
    | squareList (a::l) = a*a::squareList(l);