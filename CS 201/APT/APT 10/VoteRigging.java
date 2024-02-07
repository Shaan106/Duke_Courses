import java.util.Arrays;
import java.util.Collections;

public class VoteRigging {
    public int minimumVotes(int[] votes) {
        // fill in code here

        if (votes.length  == 1) {
            return 0;
        }

        int myVotes = votes[0];
        Integer[] otherCandidates = new Integer[votes.length - 1];

        for (int i = 1; i < votes.length; i++){
            otherCandidates[i-1] = votes[i];
        }

        int currentMaxVote = Collections.max(Arrays.asList(otherCandidates));

        int votesChanged = 0;

        Arrays.sort(otherCandidates, Collections.reverseOrder());

        while (myVotes <= currentMaxVote) {
            
            otherCandidates[0] = otherCandidates[0] - 1;
            myVotes++;
            Arrays.sort(otherCandidates, Collections.reverseOrder());

            currentMaxVote = Collections.max(Arrays.asList(otherCandidates));

            votesChanged++;

            //System.out.println(Arrays.toString(otherCandidates));
            //System.out.println("myVotes: " + Integer.toString(myVotes));
            //System.out.println("currentMaxVote: " + Integer.toString(currentMaxVote));
        }

        return votesChanged;
    }

 }