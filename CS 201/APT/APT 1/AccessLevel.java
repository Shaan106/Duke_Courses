public class AccessLevel {
    public String canAccess(int[] rights, int minPermission) {
           // fill in code here
           String permissions = "";

           for (int i = 0; i < rights.length; i++) {
                if (rights[i] >= minPermission) {
                    permissions = permissions + "A";
                } else {
                    permissions = permissions + "D";
                }
           }
           return permissions;
    }
 }