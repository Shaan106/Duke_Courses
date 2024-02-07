import java.util.*;

public class RotateString_old {
    
    public boolean rotateString(String s, String goal) {
        if (s.length() != goal.length()) {
            return false;
        }

        char pivot = goal.charAt(0);

        char[] s_array = s.toCharArray();

        boolean found = false;

        int pivot_index = -1;

        while (!found && pivot_index < s_array.length-1) {
            pivot_index++;
            if (pivot == s_array[pivot_index]) {
                found = true;
            }
        }

        if (!found) return false;

        List<Character> checkRotate = new ArrayList<>();

        for (int i = 0; i < s_array.length; i++) {
            checkRotate.add(s_array[(pivot_index+i) % s_array.length]);
        }

        StringBuilder sb = new StringBuilder();
 
        for (Character ch : checkRotate) {
            sb.append(ch);
        }
 
        // convert in string
        String string = sb.toString();

        System.out.println(string);
        System.out.println(goal);

        if (string.equals(goal)) return true;
        
        return false;
        
    }

}
