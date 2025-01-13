(* 
For this excercise, you will be filling in the contents of the following functor:
functor F(M: ORD_MAP where type Key.ord_key = string)
         (S: ORD_SET where type Key.ord_key = string) :>
sig
  val proc: string list -> S.set M.map
end
= 
struct
    ... 
end

The proc function takes a list of strings (which are file names), and builds a map of sets. 
The map maps strings (i.e., words) to the set of files names in which they appear. 
Words are separated by spaces (or newlines). 
For example, if you were passed ["a.txt","b.txt"] and a.txt had this contents:

Hello World
test
and b.txt had this contents:
a test input

Your function should return a map that maps “Hello” and “World” to the set {a.txt}, 
“test” to the set {a.txt, b.txt} and “a” and “input” to the set {b.txt}.
Checking out the String, and TextIO structures are highly recommended for implementing this function.
You should then instantiate your functor on at least one structure instantiated 
from one of the built-in ORD_MAP and ORD_SET functors and test it out.
 *)


functor F(M: ORD_MAP where type Key.ord_key = string)
         (S: ORD_SET where type Key.ord_key = string) :>
sig
  val proc: string list -> S.set M.map
end = 
struct

    (* fileToWords - reads a file, returns a stream of words *)
    fun fileToWords filename =
        let
            val inStream = TextIO.openIn filename
            val contents = TextIO.inputAll inStream
            val _ = TextIO.closeIn inStream      
        in
            String.tokens Char.isSpace contents
        end

    (* sortFile - sorts one file *)
    fun sortFile (filename, wordFileMap) = 
        (* do something to add contents of filename to map *)
        let
            val words = fileToWords filename
            fun addWordToMap (word, wordFileMap2) = 
                case M.find(wordFileMap2, word) of
                    SOME set => M.insert(wordFileMap2, word, S.add(set, filename))
                    | NONE => M.insert(wordFileMap2, word, S.add(S.empty, filename))
                
        in
            (* for each word in file *)
            foldl addWordToMap wordFileMap words
        end
    
    fun proc inputTextFiles = 
        foldl sortFile M.empty inputTextFiles
end


(* ---------- Testing -------------*)

structure StringMap = RedBlackMapFn(
struct
    type ord_key = string
    val compare = String.compare
end)

structure StringSet = RedBlackSetFn(
struct
    type ord_key = string
    val compare = String.compare
end)

(* new structure with function *)
structure WordOccurrences = F(StringMap)(StringSet)

(* Test function *)
fun test () =
    let
        (* Create temporary test files *)
        val file1 = "a.txt"
        val file2 = "b.txt"
        val _ = 
            let
                val out1 = TextIO.openOut file1
                val _ = TextIO.output(out1, "Hello World\ntest")
                val _ = TextIO.closeOut out1
                val out2 = TextIO.openOut file2
                val _ = TextIO.output(out2, "a test input")
                val _ = TextIO.closeOut out2
            in
                ()
            end

        (* Process the files *)
        val result = WordOccurrences.proc [file1, file2]

        (* Helper function to print set contents *)
        fun printSet set =
            StringSet.app (fn x => print(x ^ " ")) set

        (* Print results *)
        fun printMapEntry (key, value) =
            (print ("Word '" ^ key ^ "' appears in files: ");
             printSet value;
             print "\n")
    in
        (StringMap.appi printMapEntry result;
         (* Clean up test files *)
         OS.FileSys.remove file1;
         OS.FileSys.remove file2)
    end