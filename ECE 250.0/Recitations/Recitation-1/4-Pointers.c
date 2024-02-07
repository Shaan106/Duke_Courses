#include <stdio.h>
#include <stdlib.h>

int sumArray(int* myarray) {

    int sum = 0;

    for (int i = 0; i < 100; i++) {
        sum += myarray[i];
        // + 1 in memory is plus 4 bytes because integers take 4 bytes of memory.
    }

    return sum;

}

int main() {

    int numbers[100];

    for (int i = 0; i < 100; i++) {
        numbers[i] = i;
    }

    printf("total sum: %d", sumArray(numbers));

}