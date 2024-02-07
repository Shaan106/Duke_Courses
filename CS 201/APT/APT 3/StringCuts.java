import java.util.ArrayList; // import the ArrayList class

public class StringCuts {
    public String[] filter(String[] list, int minLength) {

        ArrayList<String> returnWords = new ArrayList<String>(); 
        
        for (int i = 0; i < list.length; i++) {
            if (list[i].length() >= minLength && !returnWords.contains(list[i])) {
                returnWords.add(list[i]);
            }
        }

        String[] finalReturnArray = returnWords.toArray(new String[returnWords.size()]);
        // replace this with your code
        return finalReturnArray;
    }
}

