import java.util.*;

public class FlatLandSpaceStation {
    static int flatlandSpaceStations(int n, int[] c) {
        if (c.length == 1) return Math.max( Math.abs(c[0]-0), Math.abs(c[0]-(n-1)) );
        Arrays.sort(c);
        int maxDist = -1;
        for (int i = 0; i < c.length-1; i++) if (c[i+1] - c[i] > maxDist) maxDist = c[i+1] - c[i];
        maxDist = maxDist / 2;
        return Math.max(Math.max(c[0], Math.abs(c[c.length-1]-(n-1))),maxDist);
    }
}


//working code that has not been condensed

// static int flatlandSpaceStations(int n, int[] c) {
//     //if 1 spacestation return max of either ends of space stations
//     if (c.length == 1) {
//         return Math.max( Math.abs(c[0]-0), Math.abs(c[0]-(n-1)) );
//     }

//     Arrays.sort(c);

//     //find max dist between adjacent space stations
//     int maxDist = -1;
//     int dist = 0;
//     for (int i = 0; i < c.length-1; i++) {
//         dist = c[i+1] - c[i];
//         if (dist > maxDist) maxDist = dist;
//     }
//     maxDist = maxDist / 2;

//     //check if ends are larger
//     int row_ends = Math.max(c[0], Math.abs(c[c.length-1]-(n-1)));

//     return Math.max(row_ends,maxDist);
// }