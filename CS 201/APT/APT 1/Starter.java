import java.util.ArrayList;
import java.util.Objects;

public class Starter {
    public int begins(String[] words, String first) {

        ArrayList<String> seenWords = new ArrayList<String>();

        for (int i = 0; i < words.length; i++) {
            if (!seenWords.contains(words[i]) && Objects.equals(words[i].charAt(0), first.charAt(0))) { 
                seenWords.add(words[i]);
            }
        }

        return seenWords.size();
    }
}