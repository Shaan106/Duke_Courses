public class Gravity {
    public double falling(double time, double velo){
      // fill in code here v0*t + 0.5*a*t2
      return ((velo*time) + (0.5*9.8*time*time));
    }
}