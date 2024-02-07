import java.util.*;

class Result {

    /*
     * Complete the 'superReducedString' function below.
     *
     * The function is expected to return a STRING.
     * The function accepts STRING s as parameter.
     */
     

    public static String superReducedString(String s) {
    // Write your code here
        
        if (s.length() == 0) return "Empty String";
        if (s.length() == 1) return s;

        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) == s.charAt(i-1)) {
                return superReducedString(s.substring(0, i - 1) + s.substring(i + 1));
            }
        }

        return s;

    }

}
