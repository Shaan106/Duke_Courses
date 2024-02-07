public class ListSum {
    public int sum(ListNode list, int thresh) {
        // replace statement below with code you write
        int sum = 0;

        if (list == null) {
            return 0;
        }

        while (list.next != null) {
            if (list.info > thresh) {
                sum = sum + list.info;
            }
            list = list.next;
        }

        
        if (list.info > thresh) {
            sum = sum + list.info;
        }
        

        return sum;
    }
}