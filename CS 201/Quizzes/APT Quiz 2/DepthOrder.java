import java.util.*;

public class DepthOrder {

    Map<Integer, ArrayList<Integer>> NodesAtDepth = new HashMap<>();


    public void traverseTree(TreeNode subtree, Integer depth) {

        if (subtree != null) {

            if (NodesAtDepth.containsKey(depth)) {
                NodesAtDepth.get(depth).add(subtree.info);
            } else {
                NodesAtDepth.put(depth, new ArrayList<>());
                NodesAtDepth.get(depth).add(subtree.info);
            }

            //checkLeft
            traverseTree(subtree.left, depth + 1);

            //checkRight
            traverseTree(subtree.right, depth + 1);
        }
    }

    public int[] order(TreeNode root) {
        // TODO: fill in code here

        traverseTree(root, 0);

        ArrayList<Integer> combinedList = new ArrayList<>();

        for (Integer key : NodesAtDepth.keySet()) {

            ArrayList<Integer> tempList = NodesAtDepth.get(key);

            Collections.sort(tempList);

            for (int item : tempList) {
                combinedList.add(item);
            }
        }

        int[] returnArray = new int[combinedList.size()];

        for (int i = 0; i < returnArray.length; i++) {
            returnArray[i] = combinedList.get(i);
        }


        return returnArray;
    }
}