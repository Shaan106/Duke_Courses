#include <stdio.h>
#include <stdlib.h>

int length(char* strinput) {
    int length = 0;

    //have to deref strinput; because you are passing in pointers but you need to check the value stored at the pointer
    while (*strinput != 0) {
        //while the letter we are pointing at is not null
        //increment length by one
        //increment memory pointer of string by 1
        length++;
        strinput++; // one char only takes one byte, therefore increase pointer only by 1
    }

    return length;
}

int main(int argc, char* argv[]) {

    //argc is number of "words" when running program
    //argv is array of arguments
    // ./q3 word => argc = 2
    // ./q3 => arg = 1

    if (argc < 2) {
        //have to input the argument in the command line with the function this time, not while it is running

        /*
        (base) shaanyadav@Shaans-Laptop Recitation-1 % g++ -g -o stringLength 3-Strings.c
        clang: warning: treating 'c' input as 'c++' when in C++ mode, this behavior is deprecated [-Wdeprecated]
        (base) shaanyadav@Shaans-Laptop Recitation-1 % ./stringLength wordd              
        Length 5 
        */
        printf("Usage: arglen <string>\n");
        exit(1);
    }

    //print length of first input argument which in this case is the string
    printf("Length %d \n", length(argv[1]));

    return EXIT_SUCCESS;

}