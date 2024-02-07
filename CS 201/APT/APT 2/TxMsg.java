public class TxMsg {
    private final char[] vowls = {'a', 'e', 'i', 'o', 'u'};
    public String getMessage(String original) {
        String final_message = "";
        
        String[] words = original.split(" ");

        for(int j = 0; j<words.length; j++)
        {
            char[] characters = words[j].toCharArray();
            int vowels_values = only_vowels(characters);
            if(vowels_values != -1)
                for(int i = vowels_values; i<characters.length; i+=1)
                {
                    if(!contains_vowel(characters[i], vowls))
                    {
                        final_message += characters[i];
                        while(!contains_vowel(characters[i], vowls))
                        {
                            if(i==characters.length-1)
                            {
                                break;
                            }
                            i+=1;
                        }
                    }
                }
            else{
                final_message+=words[j];
            }
            if(j < words.length - 1)
                final_message += ' ';
        }


        return final_message;
    }


    private boolean contains_vowel(char target, char[] array)
    {
        //int index = -1;
        for(int i = 0; i<array.length; i++)
        {
            if(target == array[i])
                return true;
        }
        return false;
    }

    private int only_vowels(char[] word)
    {
        // int num_vowel = 0;
        for(int i = 0; i<word.length; i++)
        {
            if(!contains_vowel(word[i], vowls))
                return i;

        }
        return -1;
    }
}



