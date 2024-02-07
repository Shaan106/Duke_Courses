import java.util.*;

public class UniqueMorseCodeWords {
    public int uniqueMorseRepresentations(String[] words) {

        String[] morse = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-." ,"...","-","..-","...-",".--","-..-","-.--","--.."};

        HashSet<String> morseWords = new HashSet<>();

        for (int i = 0; i < words.length; i++ ) {

            StringBuilder newMorseWord = new StringBuilder();
            
            for (int j = 0; j < words[i].length(); j++) {

                newMorseWord.append( morse[( (int) words[i].charAt(j)) - 97 ]);

            }

            morseWords.add(newMorseWord.toString());

        }
        return morseWords.size();
    }
}
