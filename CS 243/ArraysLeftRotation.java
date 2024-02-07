import java.util.*;

public class ArraysLeftRotation {

    public static List<Integer> rotLeft(List<Integer> a, int d) {
        // Write your code here

        List<Integer> returnArray1 = a.subList(0, d);
        List<Integer> returnArray2 = a.subList(d, a.size());

        returnArray1.addAll(returnArray2);

        return returnArray2;
    
    }
    
}
