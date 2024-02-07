import java.util.*;

public class IsomorphicWords {
    public int countPairs(String[] words) {
        // fill in code here

        int returnTotal = 0;

        int wordLen = words[0].length();

        for (int i = 0; i<words.length; i++) {

            //looping from i onwards to ensure no repeated counts.
            for (int j = i; j<words.length; j++) {

                if (!(i == j)) {
                    Map<Character,Character> isomorphicDict = new HashMap<>();

                    char[] word1Array = words[i].toCharArray();
                    char[] word2Array = words[j].toCharArray();

                    Boolean wordValid = true;
                    int a = 0;

                    while (wordValid && a < wordLen) {
                        if (!isomorphicDict.containsKey(word1Array[a])) {
                            if (isomorphicDict.containsValue(word2Array[a])) {
                                wordValid = false;
                            } else {
                                isomorphicDict.put(word1Array[a], word2Array[a]);
                            }
                        } else {
                            if (!isomorphicDict.get(word1Array[a]).equals(word2Array[a])) {
                                wordValid = false;
                            }
                        }
                        a = a +1;
                    }

                    if (wordValid) {
                        returnTotal = returnTotal + 1;
                    }


                }

            }

            

        }

        //divide by two because checking each word twice.
        // not needed anymore, switch loops to only go from after i.
        return returnTotal;
    }
 }