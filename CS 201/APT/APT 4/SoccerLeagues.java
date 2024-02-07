public class SoccerLeagues {
    public int[] points(String[] matches) {
        // you write code here

        int[] scoreArray = new int[matches.length];

        for (int i = 0; i < scoreArray.length; i++) {
            scoreArray[i] = 0;
        }

        //adding up home scores

        for (int i = 0; i < matches.length; i++) {
            String[] homeMatches = matches[i].split("");

            for (int j = 0; j < homeMatches.length; j++) {
                if (homeMatches[j].equals("W")) {
                    scoreArray[i] = scoreArray[i] + 3;
                    scoreArray[j] = scoreArray[j] + 0;

                } else if (homeMatches[j].equals("L")) {
                    scoreArray[i] = scoreArray[i] + 0;
                    scoreArray[j] = scoreArray[j] + 3;

                } else if (homeMatches[j].equals("D")) {
                    scoreArray[i] = scoreArray[i] + 1;
                    scoreArray[j] = scoreArray[j] + 1;

                }
            }
        }

        return scoreArray;
    }
}