import java.util.*;

public class Anonymous_old {
    public int howMany(String[] headlines, String[] messages) {
        // fill in code here

        Map<String,Integer> headlineLetters = new HashMap<String,Integer>();
        int returnVal = 0;
          
        for (String headline : headlines) {
            String[] headlineCharArray = headline.toLowerCase().split("");

            for (String headlineChar : headlineCharArray) {

                if (headlineLetters.containsKey(headlineChar)) {
                    headlineLetters.put(headlineChar, headlineLetters.get(headlineChar) + 1);
                } else {
                    headlineLetters.put(headlineChar, 1);
                }
            }
        }

        for (int i = 0; i < messages.length; i++) {
            Boolean flag = false;
            Map<String,Integer> lettersInMessage = new HashMap<String,Integer>();
            String[] messageChars = messages[i].toLowerCase().split("");

            for (String messageChar : messageChars) {
                if (lettersInMessage.containsKey(messageChar)) {
                    lettersInMessage.put(messageChar, lettersInMessage.get(messageChar) + 1);
                } else {
                    lettersInMessage.put(messageChar, 1);
                }
            }

            for (Map.Entry<String, Integer> entry : lettersInMessage.entrySet()) {
                if (headlineLetters.containsKey(entry.getKey())) {
                    if (headlineLetters.get(entry.getKey()) <= entry.getValue()) {
                        flag = true;
                    }
                }

              }
            
            if (flag.equals(true)) {
                returnVal = returnVal + 1;
            }

        }


        return returnVal;
    }
 }


