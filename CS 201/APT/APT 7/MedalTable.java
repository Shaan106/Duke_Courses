import java.util.*;

public class MedalTable {
    public String[] generate(String[] results) {
        // you fill in this code

        //map with key is country code and val is array with {G, S, B}
        Map<String, Integer[]> countryMedalCount = new HashMap<>();

        //comparator comparing country codes
        class CompareCountryMedals implements Comparator<String> {

            @Override
            public int compare(String countryA, String countryB) {
                // TODO Auto-generated method stub
                Integer[] medalsA = countryMedalCount.get(countryA);
                Integer[] medalsB = countryMedalCount.get(countryB);

                for (int i = 0; i < medalsA.length; i++) {
                    if (medalsB[i] > medalsA[i]) {
                        return 1;
                    } else if (medalsA[i] > medalsB[i]) {
                        return -1;
                    }
                }

                return countryA.compareTo(countryB);
            }

        }

        for (int i = 0; i < results.length; i++) {
            String[] eventResult = results[i].split(" ");

            for (int j = 0; j < eventResult.length; j++) {
                if (!countryMedalCount.containsKey(eventResult[j])) {
                    Integer[] tempResultsArray = {0,0,0};
                    tempResultsArray[j] = 1;
                    countryMedalCount.put(eventResult[j], tempResultsArray);
                } else {
                    Integer[] tempResultsArray = countryMedalCount.get(eventResult[j]);
                    tempResultsArray[j] = tempResultsArray[j] + 1;
                    countryMedalCount.put(eventResult[j], tempResultsArray);
                }
            }

        }

        //convert HashMap to string array

        String[] countries = new String[countryMedalCount.size()];
        int counter = 0;
        
        for (String key : countryMedalCount.keySet()) {
            countries[counter] = key;
            counter++;
        }

        Comparator<String> comp = new CompareCountryMedals();
        Arrays.sort(countries, comp);
        String[] returnArray = new String[countries.length];


        for (int i = 0; i < returnArray.length; i++) {
            Integer[] countryMedals = countryMedalCount.get(countries[i]);

            String countryMedalsString = countryMedals[0].toString() + " " + countryMedals[1].toString() + " " + countryMedals[2].toString();

            returnArray[i] = countries[i] + " " + countryMedalsString;
        }

        return returnArray;
    }
  }