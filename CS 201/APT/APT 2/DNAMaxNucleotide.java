public class DNAMaxNucleotide {
    public String max(String[] strands, String nuc) {
        int maxOccur = 0;
        char charNuc = nuc.charAt(0);
        int maxIndex = 0;
        for (int i = 0; i < strands.length; i++)
        {
            int tempMaxOccur = 0;
            for (int j = 0; j  < strands[i].length(); j++)
            {
                if (strands[i].charAt(j) == charNuc) 
                {
                    tempMaxOccur++;
                }
            }
            if (tempMaxOccur > maxOccur) 
            {
                maxOccur = tempMaxOccur;
                maxIndex = i;
            }
            else if (tempMaxOccur == maxOccur)
            {
                if (strands[i].length() > strands[maxIndex].length())
                {
                    maxIndex = i;
                }
            }
        }

        if (maxOccur == 0) 
        {
            return "";
        }
        else {
            return strands[maxIndex];
        }
    }
 }
