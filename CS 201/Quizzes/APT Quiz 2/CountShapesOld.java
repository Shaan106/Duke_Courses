import java.util.*;

public class CountShapesOld {

    //0 is left, 1 is right, -1 is when at null
    List<Integer> originalTreePath = new ArrayList<>();

    public void traverseOriginalTree(TreeNode subtree) {
        if (subtree != null) {

            //checkLeft
            originalTreePath.add(0);
            traverseOriginalTree(subtree.left);

            //checkRight
            originalTreePath.add(1);
            traverseOriginalTree(subtree.right);
        } else {
            originalTreePath.add(-1);
        }
    }

    int indexForTrav = 0;

    public Boolean isPossibleToTravTree(TreeNode subtree) {

        if (indexForTrav > originalTreePath.size()-1) {
            return false;
        } else {

            if (originalTreePath.get(indexForTrav) == 0) {
                return isPossibleToTravTree(subtree.left);
            } else if (originalTreePath.get(indexForTrav) == 0) {
                return isPossibleToTravTree(subtree.right);
            }

        }

        return false;
    }

    List<Integer> subTreePath = new ArrayList<>();

    public void traverseSubTree(TreeNode subtree) {
        if (subtree != null) {

            //checkLeft
            subTreePath.add(0);
            traverseSubTree(subtree.left);

            //checkRight
            subTreePath.add(1);
            traverseSubTree(subtree.right);
        } else {
            subTreePath.add(-1);
        }
    }

    public Boolean attemptTraverse(TreeNode subRoot) {

        traverseSubTree(subRoot);

        System.out.println(originalTreePath);
        System.out.println(subTreePath);

        if (subTreePath.size() < originalTreePath.size()) {
            subTreePath = new ArrayList<>();
            return false;
        }

        List<Integer> checkWithList = subTreePath.subList(0, originalTreePath.size());

        System.out.println(checkWithList);

        for (int j = 0; j < checkWithList.size(); j++) {

            if (checkWithList.get(j) != originalTreePath.get(j)) {
                subTreePath = new ArrayList<>();
                return false;
            }

        }
        return true;
        
    }

    int countOfThings = 0;

    public void traverseTreeAndCount(TreeNode subtree) {

        if (subtree != null) {
            //on tree

            Boolean isPossible = attemptTraverse(subtree);

            System.out.println(isPossible);

            if (isPossible) {
                countOfThings++;
            }

            //checkLeft
            traverseTreeAndCount(subtree.left);

            //checkRight
            traverseTreeAndCount(subtree.right);
        }

    }


    public int count(TreeNode countThis, TreeNode root) {

            System.out.println("---------------------------------------------");

            traverseOriginalTree(countThis);
            // TODO: fill in code here

            traverseTreeAndCount(root);

            //find a traversal path for original tree, and then try execute it on new tree on every node    

            return countOfThings;
      }
  }