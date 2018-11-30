#include <stdio.h>
#include <stdlib.h>
#define NUM 8

int count = 0;
int *result;

// FILE source.c:
void init();
void clear(int index);
void printResult();
int fnJudge(int num);
int fnRowJudge(int row);

// FILE source1.c:
void Queen_Force();

// FILE source2.c
void Queen_Recur(int row);

#include "source.c"
#include "source1.c"
#include "source2.c"
