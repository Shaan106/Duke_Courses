public class TreeTighten {

    
    public TreeNode tighten(TreeNode t) {

        
        if (t.right == null ^ t.left == null) {

            TreeNode newNode;

            if (t.left == null) {
                newNode = tighten(t.right);
            } else {
                newNode = tighten(t.left);
            }

            t.info = newNode.info;

            return newNode;

        }

        if (t.left != null) {
            t.left = tighten(t.left);
        }

        if (t.right != null) {
            t.right = tighten(t.right);
        }


        return t;


    }

    
}