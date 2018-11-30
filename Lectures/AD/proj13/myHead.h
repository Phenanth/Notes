#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int **LCS(char *str1, char* str2);
void structureSequence(int **result, char *str1, int len1, int len2);
int **generateArray(int len1, int len2);
void printArray(int **result, int len1, int len2);

#include "source.c"
