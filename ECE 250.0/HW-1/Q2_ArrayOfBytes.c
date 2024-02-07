#include <stdio.h>
#include <stdlib.h>

float *e_ptr;

float foo(float *x, float *y, float *z)
{
    //printf("%f\n", *x);
    //printf("%f\n", *y);
    //printf("%f\n", *z);

    if (*x > *y + *z)
    {
        return *x;
    }
    else
    {
        return *y + *z;
    }
}

int main()
{
    float a = 1.2;
    e_ptr = &a; //e_ptr is mem adress of a 
    float *b_ptr = (float *)malloc(2 * sizeof(float));
    b_ptr[0] = 7.0; 
    b_ptr[1] = 4.0;

    float c = foo(e_ptr, b_ptr, b_ptr + 1); 

    //printf("%f\n",c);

    free(b_ptr);
    if (c > 10.5)
    {
        //printf("%d",0);
        return 0;
    }
    else
    {
        //printf("%d",1);
        return 1;
    }
}


/*

1) 
a - good
b - good
c - check? + add hex - WRONG
d - good + CONVERT TO HEX
e - good 
f - good


Where do each of the following variables live (global data, stack, or heap)?
a. a - stack
b. b_ptr - stack
c. *b_ptr - heap
d. e_ptr - global data
e. *e_ptr - stack (because it points to a, which resides on the stack, but e_ptr is global data)



2b) returns 0;


. Include a picture of a fish in question 3 of your written submission
PDF for one point of еxtra сredit.) 

Q3 - 
Unoptimised compilation:
    (base) shaanyadav@Shaans-Laptop HW-1 % time ./myProgramUnopt
    ./myProgramUnopt  0.28s user 0.00s system 99% cpu 0.285 total

Optimised compilation:
    (base) shaanyadav@Shaans-Laptop HW-1 % time ./myProgramOpt 
    ./myProgramOpt  0.12s user 0.01s system 39% cpu 0.316 total

Percent faster = 100 - ((opt time)/(unopt time))*100
               = 57.14%



*/