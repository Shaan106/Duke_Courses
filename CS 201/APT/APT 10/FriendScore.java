// import java.util.*;

// public class FriendScore {
//     public int highestScore(String[] friends) {
//        // you fill in code here

//         Integer[] numTwoFriends = new Integer[friends.length];

//         int tempNumTwoFriends = 0;


//         for (int i = 0; i < friends.length; i++) {

//             tempNumTwoFriends = 0;

//             for (int j = 0; j < friends[i].length(); j++) {

//                 if (i == j) {
//                     continue;

//                 } else if (friends[i].charAt(j) == 'Y') {
//                     tempNumTwoFriends++;

//                     //check if friend[j] knows people friends[i] doesn't

//                     for (int x = 0; x < friends[j].length(); x++) {

//                         if ((friends[j].charAt(x) == 'Y') && (friends[i].charAt(x) == 'N') && (x!=i)) {
//                             tempNumTwoFriends++;
//                         }

//                     }

//                 }

//             }

//             numTwoFriends[i] = tempNumTwoFriends;

//         }

//         int returnVal = Collections.max(Arrays.asList(numTwoFriends));

//        return returnVal;
//     }
//  }

import java.util.*;

public class FriendScore {
    public int highestScore(String[] friends) {

        int n = friends.length;

        List<Set<Integer>> myGraph = new ArrayList<>();

        for(int i = 0; i < n; i++) {
            myGraph.add(new HashSet<>());
        }

        // First add everyone who is one level friends for i-th person

        for(int i = 0; i < n; i++) {
            char[] line = friends[i].toCharArray();
            for(int j = 0; j < n; j++) {
                if(line[j] == 'Y') {
                    myGraph.get(i).add(j);
                }
            }
        }

        // For each of i-th person's friends, check if that friendship is mutual

        for(int i = 0; i < n; i++) {
            for(int friend : myGraph.get(i)) {
                if(!myGraph.get(friend).contains(i)) {
                    myGraph.get(i).remove(friend);
                }
            }
        }

        // For each of i-th person, add their friend's friends

        List<Set<Integer>> secondFriends = new ArrayList<>();

        for(int i = 0; i < n; i++) {
            secondFriends.add(new HashSet<>());
        }

        for(int i = 0; i < n; i++) {
            for(int friend : myGraph.get(i)) {
                for(int friendsFriend: myGraph.get(friend)) {
                    if(friendsFriend != i) { // Don't add myself
                        secondFriends.get(i).add(friendsFriend);
                    }
                }
            }
        }

        for (int i = 0; i < myGraph.size(); i++) {
            Set<Integer> person = myGraph.get(i);
            person.addAll(secondFriends.get(i));
        }

        return Collections.max(myGraph, new Comparator<Set<Integer>>() {
            @Override
            public int compare(Set<Integer> o1, Set<Integer> o2) {
                return o1.size() - o2.size();
            }
        }).size();
    }
}