import java.util.*;

public class LunchPlans {
    public String[] favorites(String[] preferences) {
        
        ArrayList<HashSet<String>> listOfFoodSets = new ArrayList<>();

        for (int i = 0; i < preferences.length; i++) {
            String[] tempArray = preferences[i].split(" ");

            listOfFoodSets.add(new HashSet<>(Arrays.asList(tempArray)));
        }

        HashSet<String> returnSet = listOfFoodSets.get(0);

        for (int i = 0; i < listOfFoodSets.size(); i++) {
            returnSet.retainAll(listOfFoodSets.get(i));
        }

        ArrayList<String> unorderedItems = new ArrayList<>(returnSet);

        String[] preferenceOfItems = preferences[0].split(" ");

        ArrayList<String> returnList = new ArrayList<>();

        for (int i = 0; i < preferenceOfItems.length; i++) {
            if (unorderedItems.contains(preferenceOfItems[i]) && !returnList.contains(preferenceOfItems[i])) {

                returnList.add(preferenceOfItems[i]);

            }
        }

        String[] returnArray = new String[unorderedItems.size()];

        for (int i = 0; i <returnArray.length; i++) {
            returnArray[i]  = returnList.get(i);
        }

        return returnArray;
    }
}