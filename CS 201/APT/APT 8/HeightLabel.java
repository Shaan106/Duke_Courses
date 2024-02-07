public class HeightLabel {

    public int maxHeight(TreeNode subtree, int currentMax, int currentDepth) {

        if (subtree != null) {

            int checkLeft = maxHeight(subtree.left, currentMax, currentDepth + 1);

            int checkRight = maxHeight(subtree.right, currentMax, currentDepth + 1);

            return Math.max(checkLeft, checkRight);

        } else {
            if (currentDepth > currentMax) {
                currentMax = currentDepth;
            }
            return currentMax;
        }

    }

    public TreeNode rewire2(TreeNode subtree) {

        if (subtree != null) {

            subtree.left = rewire2(subtree.left);
            subtree.right = rewire2(subtree.right);

            subtree.info = maxHeight(subtree, 0, 0);

            return subtree;

        } else {
            return null;
        }
    }

    public TreeNode rewire(TreeNode t) {
        // replace with working code
        TreeNode returnTree = rewire2(t);

        return returnTree;
    }
}