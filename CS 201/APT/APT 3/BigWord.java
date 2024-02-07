import java.util.*;

public class BigWord {
    public String most(String[] sentences) {
        // you write code here

        Map<String, Integer> a = new HashMap<String, Integer>();

        for (String sentence : sentences) {
            String[] sentenceArray = sentence.split(" ");

            for (String word : sentenceArray) {
                if (a.containsKey(word.toLowerCase())) {
                    a.put(word.toLowerCase(), a.get(word.toLowerCase()) + 1);
                } else {
                    a.put(word.toLowerCase(), 1);
                }
            }
        }

        String maxKey = "";
        Integer maxVal = -1;

        for (Map.Entry<String,Integer> entry : a.entrySet()) {
            if (entry.getValue() > maxVal) {
                maxVal = entry.getValue();
                maxKey = entry.getKey().toLowerCase();
            }
        }

        return maxKey;
    }
}