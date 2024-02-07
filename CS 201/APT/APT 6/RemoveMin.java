public class RemoveMin {
    public ListNode remove (ListNode list) {
        
        //find min value

        ListNode tempList1 = list;
        int minVal = tempList1.info;
        int minIndex = 0;
        int tempIndex = 0;

        while (tempList1 != null) {
            if (tempList1.info < minVal) {
                minVal = tempList1.info;
                minIndex = tempIndex;
            }
            tempIndex++;
            tempList1 = tempList1.next;
        }

        //remove min value

        ListNode tempList2 = list;

        if (minIndex == 0) {
            list = list.next;
        } else {
            for (int i = 0; i < minIndex; i++) {
                if (i == minIndex - 1) {
                    tempList2.next = tempList2.next.next;
                }
                tempList2 = tempList2.next;
            }
        }

        

        System.out.println(minIndex);

        return list;
    }
}