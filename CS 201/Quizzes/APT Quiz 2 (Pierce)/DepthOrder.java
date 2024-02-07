import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

public class DepthOrder {
    HashMap<Integer, ArrayList<Integer>> depths = new HashMap<>();
    int maxDepth = 0;
    int numNodes = 0;
    public void traverse(TreeNode node, Integer depth) {
        if (node != null) {
            if (depths.containsKey(depth)) {
                depths.get(depth).add(node.info);
            } else {
                depths.put(depth, new ArrayList<>());
                depths.get(depth).add(node.info);
            }
            maxDepth = depth;
            numNodes++;
            traverse(node.left, depth + 1);
            traverse(node.right, depth + 1);
        }
    }

    public int[] order(TreeNode root) {
        traverse(root, 0);
        ArrayList<Integer> concatenated = new ArrayList<>();
        for (Integer key : depths.keySet()) {
            ArrayList<Integer> temp = depths.get(key);
            Collections.sort(temp);
            for (int j = 0; j < temp.size(); j++) {
                concatenated.add(temp.get(j));
            }
        }
        int[] result = new int[concatenated.size()];
        for (int i = 0; i < result.length; i++){
            result[i] = concatenated.get(i);
        }
        return result;
    }
    

}