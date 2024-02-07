import java.util.*;

public class AlphaLength {
    public ListNode create (String[] words) {
        // replace statement below with code you write

        Arrays.sort(words);

        Set<String> uniqueWords = new HashSet<>();

        ListNode returnNodeReference = new ListNode(0);
        ListNode returnNode = returnNodeReference;

        for (int i = 0; i < words.length; i++) {

            if (i == 0) {

                returnNode.info = words[i].length();
                uniqueWords.add(words[i]);

            } else if (!uniqueWords.contains(words[i])) {

                returnNode.next = new ListNode(words[i].length());
                returnNode = returnNode.next;
                uniqueWords.add(words[i]);

            }

        }

        return returnNodeReference;
    }
}