import java.util.*;

public class UniqueTreeValues {

    Set<Integer> uniqueValues = new TreeSet<>();

    public void findUnique(TreeNode subtree) {

        if (subtree != null) {
            
            uniqueValues.add(subtree.info);

            findUnique(subtree.right);

            findUnique(subtree.left);

        }
        
    }

    public int[] unique(TreeNode root) {

        // write code here

        findUnique(root);

        int[] returnArray = new int[uniqueValues.size()];
        int counter = 0;

        for (int val : uniqueValues) {
            returnArray[counter] = val;
            counter++;
        }

        return returnArray;
    }
}