import java.util.*;

public class SortedFreqs {
    public int[] freqs(String[] data) {
        // fill in code here

        //  Arrays.sort(data);  - use treeset

        Map<String, Integer> wordFreq = new HashMap<>();
        Set<String> sortedUniqueWords = new TreeSet<>();

        for (String word : data) {
            if (!wordFreq.containsKey(word)) {
                wordFreq.put(word, 1);
            } else {
                wordFreq.put(word, wordFreq.get(word) + 1);
            }
        }

        Collections.addAll(sortedUniqueWords, data);

        int[] returnArray = new int[sortedUniqueWords.size()];
        int counter = 0;

        for (String word : sortedUniqueWords) {
            returnArray[counter] = wordFreq.get(word);
            counter++;
        }

        return returnArray;
    }
}