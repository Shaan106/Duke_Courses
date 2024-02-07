import java.util.*;

public class SortByFreqs {

    public String[] sort(String[] data) {

        Map<String,Integer> wordFreq = new HashMap<>();

        class compareWordFrequencies implements Comparator<String> {
            @Override
            public int compare(String a, String b) {
                return wordFreq.get(b) - wordFreq.get(a);
            }
        }
        
        Comparator<String> comp = new compareWordFrequencies();

        //filling wordFreq
        for (String word : data) {
            if (!wordFreq.containsKey(word)) {
                wordFreq.put(word, 1);
            } else {
                wordFreq.put(word, wordFreq.get(word) + 1);
            }
        }

        Set<String> tempSet = new HashSet<>(Arrays.asList(data));

        String[] returnArray = new String[tempSet.size()];

        tempSet.toArray(returnArray);

        Arrays.sort(returnArray, comp.thenComparing(Comparator.naturalOrder()));

        return returnArray;
    }
 }