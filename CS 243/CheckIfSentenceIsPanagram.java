import java.util.*;

class CheckIfSentenceIsPanagram {
    public boolean checkIfPangram(String sentence) {

        HashSet<Character> charsPresent = new HashSet<>();

        for (int i = 97; i < 123; i++) {
            charsPresent.add( (char) i);
        }

        int sentenceIndex = 0;

        while ( (charsPresent.size() > 0) && (sentenceIndex < sentence.length()) ) {
            
            if (charsPresent.contains(sentence.charAt(sentenceIndex))) {
                charsPresent.remove(sentence.charAt(sentenceIndex));
            }
            
            sentenceIndex++;

        } 

        if (charsPresent.size() == 0) {
            return true;
        } else {
            return false;
        }
        
    }
}
