#include <stdio.h>
#include <stdlib.h>

// FILE source1.c:
int **fnDecrease_1(int n);

// FILE source2.c:
int **fnJohnsonTrotter(int n);
int notCompleted(int *tmp, int *dir, int n);
int maxOneInArray(int *tmp, int *dir, int n);

// FILE source.c:
int *a;
int *visit;

void init(int n);
int **initArray(int n);
int Factorial(int n);
void fnDecrease_2(int n, int tot);
void printArray(int **result, int n);

#include "source1.c"
#include "source2.c"
#include "source.c"