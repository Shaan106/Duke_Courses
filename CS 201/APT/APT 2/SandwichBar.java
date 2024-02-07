import java.util.ArrayList;
import java.util.HashSet;

public class SandwichBar {
    public int whichOrder(String[] available, String[] orders)
    {
        HashSet<String> uniqueIngredients = new HashSet<String>();

        for (String item : available) {
            uniqueIngredients.add(item);
        }

        for (int i = 0; i < orders.length; i++) {
            String[] userOrder = orders[i].split(" ");
            
            boolean flag = false;

            for (String item : userOrder) {
                if (!uniqueIngredients.contains(item)) {
                    flag = true;
                }
            }
            
            if (flag == false) {
                return i;
            }
        }
        return -1; 
    }

}