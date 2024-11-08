#include <stdio.h>
#include <time.h>

#define SIZE 256
#define ITERATIONS 10000

void transpose(int matrix[SIZE][SIZE], int transposed[SIZE][SIZE])
{
    for (int i = 0; i < SIZE; i++)
    {
        for (int j = 0; j < SIZE; j++)
        {
            transposed[j][i] = matrix[i][j];
        }
    }
}

void transposeBlocked(int matrix[SIZE][SIZE], int transposed[SIZE][SIZE], int block_size)
{
    for (int i = 0; i < SIZE; i += block_size)
    {
        for (int j = 0; j < SIZE; j += block_size)
        {
            for (int ii = i; ii < i + block_size; ii++)
            {
                for (int jj = j; jj < j + block_size; jj++)
                {
                    transposed[jj][ii] = matrix[ii][jj];
                }
            }
        }
    }
}

int main()
{
    int matrix[SIZE][SIZE];
    int transposed[SIZE][SIZE];
    clock_t start, end;
    double cpu_time_used;

    // Initialize the matrix with some values
    for (int i = 0; i < SIZE; i++)
    {
        for (int j = 0; j < SIZE; j++)
        {
            matrix[i][j] = i * SIZE + j;
        }
    }

    // Measure the time taken to transpose the matrix a thousand times
    start = clock();
    for (int k = 0; k < ITERATIONS; k++)
    {
        transpose(matrix, transposed);
    }
    end = clock();

    cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;

    printf("Unblocked time: %f seconds\n", cpu_time_used);

    for (int block_size = 1; block_size <= 256; block_size *= 2)
    {
        start = clock();
        for (int k = 0; k < ITERATIONS; k++)
        {
            transposeBlocked(matrix, transposed, block_size);
        }
        end = clock();

        cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;

        printf("Blocked time with block size %d: %f seconds\n", block_size, cpu_time_used);
    }

    return 0;
}