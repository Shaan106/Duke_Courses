public class PairDown {
    public int[] fold(int[] list) {
        // change this code

        System.out.println(list.length);
        System.out.println(list.length/2);
        System.out.println(list.length/2 + 1);
        System.out.println(list.length%2);
        
        if (list.length % 2 == 1) {

            int[] returnList = new int[list.length/2 + 1];

            for (int i = 0; i < returnList.length-1; i = i + 1) {
                returnList[i] = list[2*i] + list[2*i+1];
            }

            returnList[returnList.length-1] = list[list.length-1];

            return returnList;

        } else {

            int[] returnList = new int[list.length/2];

            for (int i = 0; i < returnList.length; i = i + 1) {
                returnList[i] = list[2*i] + list[2*i+1];
            }

            return returnList;

        }
        
    }
}