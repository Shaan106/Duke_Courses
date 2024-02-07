import java.util.*;


public class ErdosNumber {
    public String[] calculateNumbers(String[] pubs) {
      // you write code here

      //USE Breadth first search

      Map<String, Integer> authorDist = new HashMap<>();

      for (int i = 0; i < pubs.length; i++) {

        String[] arrayOfAuthors = pubs[i].split(" ");

        Boolean hasErdos = false;

        int minAuthorDist = -1;

        for (int j = 0; j < arrayOfAuthors.length; j++) {

            if (hasErdos) {
                authorDist.put(arrayOfAuthors[j], 1);
            } else if (arrayOfAuthors[j].equals("ERDOS")) {
                hasErdos = true;
            } else {

                //check if authorDist is already contained

                //check min dist in authors


            }

        }

      }


      return new String[3];
    }
  }