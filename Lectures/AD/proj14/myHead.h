#include <stdio.h>
#include <stdlib.h>

typedef struct event {
	int start;
	int finish;
}EVENT;
typedef struct event *EVENTPOINTER;

int *ActivitySelector(EVENTPOINTER events, int n, int *nrst);
int cmp(const void *p, const void *q);
EVENTPOINTER Init(int *n);
void printResult(EVENTPOINTER events, int *result, int n);
void printArray(EVENTPOINTER arr, int n);

#include "source.c"
