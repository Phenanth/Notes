#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

typedef struct point {
	int x;
	int y;
}POINT;
typedef struct point *POINTPOINTER;

POINTPOINTER closestTwoPoints(POINTPOINTER arr, int a, int b, double *dmin);
int isCompetive_x(POINTPOINTER arr, int n, int x);
int isCompetive_y(POINTPOINTER arr, int n, int y);
POINTPOINTER generatePoints(int n);
int Random(int a, int b);
int comp_x(const void *p, const void *q);
int comp_y(const void *p, const void *q);
double calDistance(POINT a, POINT b);
void printArray(POINTPOINTER arr, int n);

#include "source.c"
