import java.util.*;

public class LowestCommonAncestorOfABinaryTree {


    //treeNode Array of path to p
    //treeNode Array of path to q

    //find the furthest common path thing and then return that treenode


    //traverse every tree - if query in right tree or in left tree

    public boolean inTree(TreeNode root, TreeNode query) {

        if (root == null) return false;
        if (root == query) return true;

        return (inTree(root.left, query) || inTree(root.right, query));

    }


    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {

        //check if one node in left and one in right
        if ((inTree(root.left, q) && inTree(root.right, p)) || (inTree(root.left, p) && inTree(root.right, q))) {
            return root;
        } 
        
        // if p and q are in left subtree, check in left subtree
        if (inTree(root.left, q) && inTree(root.left, p)) return lowestCommonAncestor(root.left, p, q);

        // if p and q are in right subtree, check in right subtree
        if (inTree(root.right, q) && inTree(root.right, p)) return lowestCommonAncestor(root.right, p, q);

        return root;
    }
    
}
