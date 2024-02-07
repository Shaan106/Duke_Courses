public class UniquePaths {

    public int uniquePaths(int m, int n) {
        
        // if ( (m > 1) && (n > 1)) {
        //     return uniquePaths(m-1, n) + uniquePaths(m, n-1);
        // }

        // return 1;

        //create new num paths from index 2d array
        int[][] paths = new int[m][n];

        //set edges of num paths to 1
        for (int i = 0; i < m; i ++){
            paths[i][0] = 1;
        }
        for (int j = 0; j < n; j ++){
            paths[0][j] = 1;
        }

        //create values for num paths from a certain index
        for (int i = 1; i < m ; i ++){
            for (int j = 1; j < n; j ++){
                paths[i][j] = paths[i-1][j] + paths[i][j-1];
            }
        }
        return paths[m-1][n-1];

    }
    
}
