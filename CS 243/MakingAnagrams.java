import java.util.*;

public class MakingAnagrams {
    
    /*
     * Complete the 'makingAnagrams' function below.
     *
     * The function is expected to return an INTEGER.
     * The function accepts following parameters:
     *  1. STRING s1
     *  2. STRING s2
     */

     public static int makingAnagrams(String s1, String s2) {

        HashMap<Character, Integer> lettersS1 = new HashMap<Character, Integer>();

        int numCharDiff = 0;

        for (Character c : s1.toCharArray()) {
            if (!lettersS1.containsKey(c)) {
                lettersS1.put(c, 1);
            } else {
                lettersS1.put(c, lettersS1.get(c)+1);
            }
        }

        HashMap<Character, Integer> lettersS2 = new HashMap<Character, Integer>();

        for (Character c : s2.toCharArray()) {
            if (!lettersS2.containsKey(c)) {
                lettersS2.put(c, 1);
            } else {
                lettersS2.put(c, lettersS2.get(c)+1);
            }
        }

        System.out.println(lettersS1);

        for (Character cc : s2.toCharArray()) {
            if (!lettersS1.containsKey(cc)) {
                numCharDiff = numCharDiff + 1;
            } else if (lettersS1.get(cc) <= 0) {
                numCharDiff = numCharDiff + 1;
            } else {
                lettersS1.put(cc, lettersS1.get(cc)-1);
            }
        }

        return (numCharDiff*2);

        }


}
