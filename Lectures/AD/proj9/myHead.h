#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int **forwardElimination(int **arr, int row);
int switchRow(int **arr, int row, int n);
void printResult(int **arr, int row, int flag);
int **init(int *n);
void printArray(int **arr, int row);
void printAlt(int *arr, int row);

#include "source.c"
