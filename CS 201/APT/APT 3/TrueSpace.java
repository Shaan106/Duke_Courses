public class TrueSpace {
    public long calculateSpace(int[] sizes, int clusterSize) {
       // fill in code here

       long data = 0;

       for (int i = 0; i < sizes.length; i++) {
            int tempVal = sizes[i];

            int intVal = sizes[i] / clusterSize;
            intVal = intVal * clusterSize;
            
            if ((tempVal%clusterSize) > 0) {
                intVal = intVal + clusterSize;
            }

            data = data + intVal;
       }
       
       return data;
    }
 }