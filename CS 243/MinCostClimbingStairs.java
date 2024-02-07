import java.util.*;

class MinCostClimbingStairs {
    public int minCostClimbingStairs(int[] cost) {

        if (cost.length == 0) return 0;
        if (cost.length == 1) return cost[0];
        if (cost.length == 2) return Math.min(cost[0],cost[1]);

        int[] skip1 = Arrays.copyOfRange(cost, 1, cost.length-1);
        int[] skip2 = Arrays.copyOfRange(cost, 2, cost.length-1);

        return (Math.min(cost[0] + minCostClimbingStairs(skip1), cost[1] + minCostClimbingStairs(skip2)));
        
    }
}
