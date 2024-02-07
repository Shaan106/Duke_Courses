public class CirclesCountry {
    public int leastBorders(int[] x, int[] y, int[] r, int x1, int y1, int x2, int y2) {

        int circlesCrossed = 0;

        for (int i = 0; i < x.length; i++) {
            
            if ( (isInCircle(x[i], y[i], r[i], x1, y1) && !isInCircle(x[i], y[i], r[i], x2, y2)) || (!isInCircle(x[i], y[i], r[i], x1, y1) && isInCircle(x[i], y[i], r[i], x2, y2)) ) {
                circlesCrossed = circlesCrossed + 1;
            }
        }

        // you write code here
        return circlesCrossed;
    }
    public boolean isInCircle(int circle_x, int circle_y, int radius, int point_x, int point_y) {
        
        //pythagorean dist between circle centre and point
        double dist = Math.sqrt( (circle_x-point_x)*(circle_x-point_x) + (circle_y-point_y)*(circle_y-point_y) );

        if (dist > radius) {
            return false;
        } else {
            return true;
        }
        

    }
 }