#include <stdio.h>
#include <stdlib.h>

void some_function() {
    int *p = 0;
    int x = *p;
}

int main()
{
    some_function();
}