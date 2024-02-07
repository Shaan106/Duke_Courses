

import java.util.*;

public class Aaagmnrs {
    public String[] anagrams(String[] phrases) 
    {
        boolean value = true;
        List<String> finList= new ArrayList<String>();
        Set<String> keepTrack = new HashSet<>();
        for(int i = 0; i<phrases.length; i++)
        {  
            if(!keepTrack.contains(phrases[i]))
            {
                finList.add(phrases[i]);
            }

            Map<Character, Integer> totLetter0 = new HashMap<>();
            String tester = phrases[i].replaceAll(" ","");
            tester = tester.toLowerCase();
            char[] letters = tester.toCharArray();
            for(char c : letters)
            {
                totLetter0.putIfAbsent(c, 0);
                totLetter0.put(c, totLetter0.get(c)+1);
            }


            for (int j=i+1; j<phrases.length; j++)
            {
                Map<Character, Integer> totLetter1 = new HashMap<>();
                String using = phrases[j].replaceAll(" ","");
                using = using.toLowerCase();
                char[] chars = using.toCharArray();
                for(char c : chars)
                {
                    totLetter1.putIfAbsent(c, 0);
                    totLetter1.put(c, totLetter1.get(c)+1);
                }
                value = true;
                for(Character c : totLetter1.keySet())
                {
                    if(!totLetter0.containsKey(c) || totLetter1.get(c) != totLetter0.get(c))
                    {
                        value = false;
                    }
                    
                }
                for(Character c : totLetter0.keySet())
                {
                    if(!totLetter1.containsKey(c) || totLetter1.get(c) != totLetter0.get(c))
                    {
                        value = false;
                    }
                    
                }
                if(value == true)
                {
                    keepTrack.add(phrases[j]);
                }
            }

        }
        return finList.toArray(new String[finList.size()]);
    }
}
