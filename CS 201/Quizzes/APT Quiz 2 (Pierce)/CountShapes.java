public class CountShapes {
   int count = 0;
    public int treeEqual(TreeNode countThis, TreeNode root){
        if(countThis != null){
            if (root == null){
                return 0;
            }
            int left = treeEqual(countThis.left, root.left);
            int right = treeEqual(countThis.right, root.right);
            if (left == 0 || right == 0){
                return 0;
            }
            return 1;
        }
        return 1;
    }

    public void iterate(TreeNode countThis, TreeNode root){
        if (root != null){
            count += treeEqual(countThis, root);
            iterate(countThis, root.left);
            iterate(countThis, root.right);
        }
    }
    
    public int count(TreeNode countThis, TreeNode root) {
          iterate(countThis, root);
          return count;
      }
  }