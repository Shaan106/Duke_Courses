import java.util.Objects;

public class Totality {
    public int sum(int[] a, String stype) {

        int final_sum = 0;

        if (Objects.equals(stype, "all")) {
            // block of code to be executed if the condition is true
            for (int i = 0; i < a.length; i++) {
                final_sum = final_sum + a[i];
            }


        } else if (Objects.equals(stype, "odd")) {

            for (int i = 1; i < a.length; i = i + 2) {
                final_sum = final_sum + a[i];
            }
        
        } else {
            for (int i = 0; i < a.length; i = i + 2) {
                final_sum = final_sum + a[i];
            }
        }
        return final_sum;
    }
}