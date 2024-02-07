import java.util.ArrayList;


public class Common{
    public int count (String a, String b) 
    {
        int points = 0;
        char[] a_ = a.toCharArray();
        ArrayList<Character> b_ = new ArrayList<Character>();
        fillArray(b_, b.toCharArray());

        for(int i = 0; i<a_.length; i++)
        {
            if(b_.contains(a_[i]))
            {
                points+=1;
                b_.remove(b_.indexOf(a_[i]));
            }
        }

        return points;
    }

    private void fillArray(ArrayList<Character> a_, char[] a)
    {
        for(int i = 0; i<a.length; i++)
        {
            a_.add(a[i]);
        }
    }
}
