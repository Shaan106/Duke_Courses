import java.util.*;

public class MemberCheck {
    public String[] whosDishonest(String[] club1, 
                                  String[] club2, 
                                  String[] club3) {
    // TODO: fill in code here

    Set<String> club1Set = new HashSet<>(Arrays.asList(club1));
    Set<String> club2Set = new HashSet<>(Arrays.asList(club2));
    Set<String> club3Set = new HashSet<>(Arrays.asList(club3));

    Set<String> club12Intersection = new HashSet<>(club1Set);
    club12Intersection.retainAll(club2Set);

    Set<String> club13Intersection = new HashSet<>(club1Set);
    club13Intersection.retainAll(club3Set);

    Set<String> club23Intersection = new HashSet<>(club2Set);
    club23Intersection.retainAll(club3Set);

    Set<String> returnSet = new HashSet<>(club12Intersection);
    returnSet.addAll(club13Intersection);
    returnSet.addAll(club23Intersection);

    String[] returnArray = new String[returnSet.size()];
    returnSet.toArray(returnArray);

    Arrays.sort(returnArray);

    return returnArray;
    }
 }