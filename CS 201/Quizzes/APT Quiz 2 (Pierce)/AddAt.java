public class AddAt {
    public ListNode addAt(ListNode list, ListNode toAdd, int index) {      
        ListNode firstNode = list;
        ListNode current = list;
        ListNode temp;
        if (list == null){
            return toAdd;
        }
        if (toAdd == null){
            return list;
        }
        if (index == 0){
            firstNode = toAdd;
            current = toAdd;
            while(current.next != null){
                current = current.next;
            }
            current.next = list;
            return firstNode;
        }
        for (int i = 0; i < index-1; i++){
            current = current.next;
        }
        temp = current.next;
        current.next = toAdd;
        while (current.next != null){
            current = current.next;
        }
        current.next = temp;
        return firstNode;
    }
  }