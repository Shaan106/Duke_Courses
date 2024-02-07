public class LevelCount {

    public int nodesAtLevel(TreeNode subtree, int levelVal, int currentLevel) {

        if (subtree == null) {

            return 0;

        } else if (currentLevel == levelVal) {

            return 1;

        } else {

            int checkRight = nodesAtLevel(subtree.right, levelVal, currentLevel + 1);

            int checkLeft = nodesAtLevel(subtree.left, levelVal, currentLevel + 1);

            return checkLeft + checkRight;
        }

    }

    public int count(TreeNode t, int level) {
        // replace with working code

        int nodesAtTheLevel = nodesAtLevel(t, level, 0);

        return nodesAtTheLevel;
    }
}