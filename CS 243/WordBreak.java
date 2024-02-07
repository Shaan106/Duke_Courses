import java.util.*;

class Solution {
    HashMap<String, Boolean> cache = new HashMap<>();

    public boolean wordBreak(String s, List<String> wordDict) {

        String checkWord;

        if (cache.containsKey(s)) return cache.get(s);
        
        for (int i = 0; i < wordDict.size(); i++) {

            if (s.equals("")) {
                return true;
            }

            if (s.length() >= wordDict.get(i).length()) {
                checkWord = s.substring(0, wordDict.get(i).length());
            } else {
                checkWord = "";
            }

            if (checkWord.equals(wordDict.get(i))) {
                Boolean value = wordBreak(s.substring(wordDict.get(i).length()), wordDict);
                cache.put(s,value);
                if (value) return true;

            }
        }    

        return false;
        
    }
}
