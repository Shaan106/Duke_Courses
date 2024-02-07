import java.util.*;

public class LeafTrails {

    Map<Integer,String> leafToBinary = new HashMap<>();

    public void traverseTree(TreeNode subtree, String pathToCurrentNode) {

        if (subtree != null) {

            if (subtree.right == null && subtree.left == null) {
                leafToBinary.put(subtree.info, pathToCurrentNode);
            }

            traverseTree(subtree.left, pathToCurrentNode + "0");

            traverseTree(subtree.right, pathToCurrentNode + "1");
        }

    }


    public String[] trails(TreeNode tree) {
        // replace with working code

        traverseTree(tree, "");

        List<Integer> keyList = new ArrayList<>();

        for (Integer key : leafToBinary.keySet()) {

            keyList.add(key);

        }

        keyList.sort(Comparator.naturalOrder());

        String[] returnArray = new String[keyList.size()];

        for (int i = 0; i < keyList.size(); i++)  {
            returnArray[i] = leafToBinary.get(keyList.get(i));
        }

        return returnArray;
    }
}