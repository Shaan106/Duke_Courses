import java.util.*;

public class HuffmanDecoding {
    public String decode(String archive, String[] dictionary) {
          // fill in code here

          ArrayList<String> dictionaryArrayList = new ArrayList<>(Arrays.asList(dictionary));

          char[] archiveArray = archive.toCharArray();

          StringBuilder returnString = new StringBuilder();
 
          //returnString.append("GFG");

          //loop through every char

          String currentChar = "";

          int charIndex = 0;

          for (int i = 0; i <  archive.length(); i++) {

            currentChar = currentChar + archiveArray[i];

            if (dictionaryArrayList.contains(currentChar)) {

                for (int j = 0; j < dictionary.length; j++) {
                    if (dictionary[j].equals(currentChar)) {
                        charIndex = j;
                    }
                }

                //System.out.println(charIndex);

                int a = 65 + charIndex;  
                char c=(char)a;  

                returnString.append(c);

                currentChar = "";

            }

            //int charIndex = Arrays.binarySearch(dictionary, returnString);

          }

          return returnString.toString();
    }
 }
