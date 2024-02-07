import java.util.*;

import javax.swing.plaf.BorderUIResource.TitledBorderUIResource;

public class OlympicCandles{

    public int numberOfNights(int[] candles){
       // write code

        //Arrays.sort(candles, Collections.reverseOrder());

        Integer[] newCandles = new Integer[candles.length];
        
        for (int i = 0; i < candles.length; i++) {
           
            newCandles[i] = candles[i];

        }

        Arrays.sort(newCandles, Collections.reverseOrder());

        int numNights = 0;

        int numCandles = newCandles.length;

        System.out.println(Arrays.toString(newCandles));

        while (numCandles > numNights) {

            for (int i = 0; i < numNights; i++) {
                newCandles[i] = newCandles[i] - 1;
    
                if (newCandles[i] == 0) {
                    numCandles = numCandles - 1;
                }
            }

            Arrays.sort(newCandles, Collections.reverseOrder());

            System.out.println(Arrays.toString(newCandles));
            System.out.println("numNights: " + Integer.toString(numNights));
            System.out.println("numCandles: " + Integer.toString(numCandles));

            if (numCandles > numNights) {
                numNights++;
            }
            
        }

       return numNights;
    }
  }