import java.util.*;

public class Increasing {
    public int[] getIncreasing(int[] numbers) {
        ArrayList<Integer> increasingArrayList = new ArrayList<>();
        int largestNum = -1;

        for (int i = 0; i < numbers.length; i++) {
            if (numbers[i] > largestNum) {
                increasingArrayList.add(numbers[i]);
                largestNum = numbers[i];
            }
        }

        int[] returnArray = new int[increasingArrayList.size()];

        for (int i = 0; i < increasingArrayList.size(); i++) {
            returnArray[i] = increasingArrayList.get(i);
        }

        return returnArray;
    }
}

