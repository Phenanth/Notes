#include <stdio.h>
#include <stdlib.h>

typedef struct point {
	int x;
	int y;
}POINT;
typedef struct point *POINTPOINTER;

// FILE source.c:
POINTPOINTER init(int* n);
int isAllSameSide(POINTPOINTER arr, int n, int i, int j);
int isSameSide(int a, int b, int c, int x, int y, int* index, int* first);
void printArray(POINTPOINTER arr, int n);

#include "source.c"
