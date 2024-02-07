public class AddAt {
    public ListNode addAt(ListNode list, ListNode toAdd, int index) {   
        
        if (list == null) {
            return toAdd;
        }

        if (index == 0) {

            if (toAdd == null) {
                return list;
            }

            ListNode nodeToAddAt = toAdd;

            while (nodeToAddAt.next != null) {
                nodeToAddAt = nodeToAddAt.next;
            }

            nodeToAddAt.next = list;

            return toAdd;
        }

        ListNode nodeToAddAt  = list;

        for (int i = 0; i < index-1; i++) {
            nodeToAddAt = nodeToAddAt.next;
        }

        ListNode oldNext = nodeToAddAt.next;

        nodeToAddAt.next = toAdd;

        while (nodeToAddAt.next != null) {
            nodeToAddAt = nodeToAddAt.next;
        }

        nodeToAddAt.next = oldNext;

        return list;
    }
  }