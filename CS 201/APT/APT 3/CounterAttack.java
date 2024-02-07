import java.util.*;

public class CounterAttack {
    public int[] analyze(String str, String[] words) {

        String[] strArray = str.split(" ");

        Map<String, Integer> a = new HashMap<String, Integer>();

        for (String letter : words) {
            a.put(letter, 0);
        }
        
        for (String letter: strArray) {
            if (a.containsKey(letter)) {
                a.put(letter, a.get(letter) + 1);
            }
        }

        int[] returnArray = new int[words.length];

        for (int i = 0; i < returnArray.length; i++) {
            returnArray[i] = a.get(words[i]);
        }

        return returnArray;
    }
}