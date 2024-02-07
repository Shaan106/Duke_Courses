import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class SimpleWordGame {
    public int points(String[] player, String[] dictionary)
    {
        int total_points = 0;   
        Set<String> players_words = new HashSet<String>(Arrays.asList(player));
        ArrayList<String> dictionary_list = new ArrayList<>(Arrays.asList(dictionary));

        for(String word : players_words)
        {
            if(dictionary_list.contains(word))
            {
                total_points += word.toCharArray().length * word.toCharArray().length;
            }
        }


        return total_points;
    }
}
