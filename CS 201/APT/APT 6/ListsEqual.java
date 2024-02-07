public class ListsEqual {
    public int equal (ListNode a1, ListNode a2) {
        // replace statement below with code you write

        boolean areListsEqual = true;
        boolean endLoop = false;

        if ((a1 == null && a2 != null) || (a2 == null && a1 != null)) {
            return 0;
        } else if (a1 == null && a2 == null) {
            return 1;
        }

        while (areListsEqual && !endLoop) {

            if ((a1.info != a2.info) || ((a1.next == null) && (a2.next != null)) || ((a2.next == null) && (a1.next != null))){
                areListsEqual = false;
            }

            if (a1.next == null || a2.next == null) {
                endLoop = true;
            }

            a1 = a1.next;
            a2 = a2.next;

        }

        if (areListsEqual) {
            return 1;
        } else {
            return 0;
        }
    }
}