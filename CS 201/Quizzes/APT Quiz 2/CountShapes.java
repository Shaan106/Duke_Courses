public class CountShapes {
    public Boolean traverseOriginalTree(TreeNode treeA, TreeNode treeB) {
        if (treeA != null) {
            if (treeB == null)
                return false;
            Boolean checkLeft = traverseOriginalTree(treeA.left, treeB.left);
            Boolean checkRight = traverseOriginalTree(treeA.right, treeB.right);

            if (checkLeft == false || checkRight == false) {
                return false;
            } else {
                return true;
            }
        } else {
            return true;
        }
    }

    int returnCount = 0;
    public void traverseRootAndCheck(TreeNode treeA, TreeNode treeB) {
        if (treeB!= null) {
            if (traverseOriginalTree(treeA, treeB)) {
                returnCount++;
            }
            traverseRootAndCheck(treeA, treeB.left);
            traverseRootAndCheck(treeA, treeB.right);
        }
    }
    public int count(TreeNode countThis, TreeNode root) {
            traverseRootAndCheck(countThis, root);
            return returnCount;
      }
  }