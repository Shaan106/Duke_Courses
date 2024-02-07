public class PathSum {

    public int checkPath(int targetVal, TreeNode subtree, int currentPath) {
        if (subtree != null) {

            int checkRight = checkPath(targetVal, subtree.right, currentPath + subtree.info);

            int checkLeft = checkPath(targetVal, subtree.left, currentPath + subtree.info);

            return checkRight + checkLeft;
        } else {
            if (currentPath == targetVal) {
                return 1;
            } else {
                return 0;
            }
        }
    }

    public int hasPath(int target, TreeNode tree){
        // replace with working code
        int numPaths = checkPath(target, tree, 0);
        System.out.println(numPaths);

        if (numPaths > 0) {
            return 1;
        } else {
            return 0;
        }
    }
}