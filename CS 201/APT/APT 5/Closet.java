import java.util.*;

public class Closet {
    public String anywhere(String[] list) {
        // replace this with your code
        Set<String> returnTreeSet = new TreeSet<>();

        String tempStringOfList = String.join(" ", list);

        String[] allWordsList = tempStringOfList.split(" ");

        for (String word : allWordsList) {
            returnTreeSet.add(word);
        }

        String returnString = String.join(" ", returnTreeSet);

        return returnString;
    }
}