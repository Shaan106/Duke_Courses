import java.util.*;

public class Translate {
    public int numAlternates(String original, String translated) {
        // TODO: fill in code here

        Map<String, HashSet<String> > wordTranslations = new HashMap<>();

        String[] originalArray = original.split(" ");
        String[] translatedArray = translated.split(" ");

        for (int i = 0; i < originalArray.length; i++) {

            if (!wordTranslations.containsKey(originalArray[i])) {
                wordTranslations.put(originalArray[i], new HashSet<>());
                wordTranslations.get(originalArray[i]).add(translatedArray[i]);
            } else {
                wordTranslations.get(originalArray[i]).add(translatedArray[i]);
            }
        }

        int totalExtraTranslations = 0;

        //System.out.println(wordTranslations);

        for (String key : wordTranslations.keySet())  {
            if (wordTranslations.get(key).size() > 1) {
                totalExtraTranslations = totalExtraTranslations + wordTranslations.get(key).size();
            }
            //System.out.print(totalExtraTranslations);
        }


        return totalExtraTranslations;

    }
}