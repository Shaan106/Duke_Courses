
import java.util.*;

public class Anonymous {
    public int howMany(String[] headlines, String[] messages) {
          // fill in code here

        Map<Character, Integer> headlineLetters = new HashMap<Character,Integer>();
        int returnVal = 0;

        //Creating hashmap of all letters
        for (String headline : headlines) {
            headline = headline.replace(" ", "");
            headline = headline.toLowerCase();

            char[] arrayOfCharsInHeadline = headline.toCharArray();

            for (char charInHeadline : arrayOfCharsInHeadline) {

                if (headlineLetters.containsKey(charInHeadline)) {
                    int tempPutVal = headlineLetters.get(charInHeadline);
                    headlineLetters.put(charInHeadline, tempPutVal + 1);
                } else {
                    headlineLetters.put(charInHeadline, 1);
                }
            }
        }

        //System.out.println(headlineLetters);

        

        //String[] arrayOfCharsInMessage;

        //Boolean isMessagePossible;

        for (String message : messages) {

            Map<Character, Integer> messageLetters = new HashMap<Character, Integer>();

            message = message.replace(" ", "");
            message = message.toLowerCase();
            Boolean isMessagePossible = true;

            char[] arrayOfCharsInMessage = message.toCharArray();
            
            for (char charInMessage : arrayOfCharsInMessage) {

                if (messageLetters.containsKey(charInMessage)) {
                    int tempPutVal = messageLetters.get(charInMessage);
                    messageLetters.put(charInMessage, tempPutVal + 1);
                } else  {
                    messageLetters.put(charInMessage, 1);
                }
            }

            //System.out.println(messageLetters);

            for (Map.Entry<Character, Integer> entry : messageLetters.entrySet()) {

                //System.out.println(entry.getKey());
                //System.out.println(entry.getValue() + headlineLetters.get(entry.getKey()));

                if (!headlineLetters.containsKey(entry.getKey())) {
                    isMessagePossible = false;
                }
                else if (entry.getValue() > headlineLetters.get(entry.getKey())) {
                    isMessagePossible = false;
                }
            }

            //System.out.println(isMessagePossible);

            if (isMessagePossible) {
                returnVal++;
            }

            
        }

        return returnVal;
    }
 }