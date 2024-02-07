import java.util.*;
public class SetAside {
    public String common(String[] list) {
        ArrayList<Set<String>> listOfSets = new ArrayList<>();
        for (int i = 0; i < list.length; i++) {
            String[] listOfWords = list[i].split(" ");
            listOfSets.add(new TreeSet<>());
            for (int j = 0; j < listOfWords.length; j++) { listOfSets.get(i).add(listOfWords[j]);}
        }
        if (listOfSets.size() == 0) {
            return "";
        } else {
            Set<String> returnTreeSet = new TreeSet<>(listOfSets.get(0));
            for (int i = 1; i < listOfSets.size(); i++) {returnTreeSet.retainAll(listOfSets.get(i));}
            String returnString = String.join(" ", returnTreeSet);
            return returnString;
        }
    }
}