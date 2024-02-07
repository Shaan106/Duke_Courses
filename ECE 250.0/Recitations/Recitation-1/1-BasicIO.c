#include <stdio.h>
#include <stdlib.h>

int main() {
    char name[32]; //name with 32 bytes of memory allocated
    int height; //height of player in inches
    int avg_ppg; //average points per game

    printf("Enter name: "); //prints the arguments
    scanf("%s", name); // %s - the input is type string; store input in name

    printf("Enter height in inches: "); 
    scanf("%d", &height); //d implies int; &height is the memory pointer to the height variable
    //height is the value in variable; &height => store the number at the memory address of height

    printf("Enter average points per game: ");
    scanf("%d", &avg_ppg);

    float points_per_inch = (float) avg_ppg / height; // f
    printf("Scored an average of %f points per inch\n", points_per_inch);
    //ppi because not needing to access its memory address, only the value.
 
}