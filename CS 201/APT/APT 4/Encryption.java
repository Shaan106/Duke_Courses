import java.lang.reflect.Array;
import java.util.*;

public class Encryption {
    public String encrypt(String message){
        // you write code here

        //String alphabet = "abcdefghijklmnopqrstuvwxyz";
        //char[] alphabetArray = alphabet.toCharArray();

        char[] arrayOfMessageChars = message.toCharArray();

        Map<Character, Character> encodingMap = new HashMap<>();

        int asciiCharVal = 97;
        //int currentLetter = 0;

        for (int i = 0; i < arrayOfMessageChars.length; i++) {
            if (!encodingMap.containsKey(arrayOfMessageChars[i])) {
                //asciiCharVal = asciiCharVal + 1;
                char encodedChar = (char) (asciiCharVal);
                //char encodedChar = alphabetArray[currentLetter];
                encodingMap.put(arrayOfMessageChars[i], encodedChar);
                asciiCharVal++;
            }
        }

        //ArrayList<Character> returnCharList = new ArrayList<>();

        char[] returnCharList = new char[arrayOfMessageChars.length];

        for (int j = 0; j < arrayOfMessageChars.length; j++) {
            returnCharList[j] = encodingMap.get(arrayOfMessageChars[j]);
            //returnCharList.add(encodingMap.get(arrayOfMessageChars[j]));
        }

        String returnString = String.valueOf(returnCharList);

        return returnString;
    }
}