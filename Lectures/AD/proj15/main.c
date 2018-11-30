/*
# 矩阵链问题

## 问题描述
题目：矩阵链问题。
描述：设 A1, A2 , … , An 为矩阵序列， 
Ai 为 Pi-1 Pi 阶矩阵，i  = 1, 2, … , n.  
试确定矩阵的乘法顺序，使得元素相乘的总次数最少。
输入：矩阵个数 n 与 n + 1 个数字，分别代表 n 个矩阵的行数与列数。
输出：矩阵链乘法加括号后的结果。

## 算法

动态规划：
根据递推方程计算各长度（从2到n）子结果的最优计算次数，
最后取得长度为n的结果作为最优计算次数算法的结果。

## 时间复杂度

动态规划：
动态规划求矩阵链最少计算次数需要从两个矩阵相乘扩展到 n 个矩阵相乘，
各个长度都需要对矩阵子链进行遍历，故算法的时间复杂度为O(n^2)。

## 输入输出

输入1：
```
6
30 35 15 5 10 20 25
```
输出1：
```
Minimum times: 15125
((A1(A2A3))((A4A5)A6))
```

输入2：
```
3
10 100 5 50
```
输出2：
```
Minimum times: 7500
((A1A2)A3)
```

## 源代码

*/
// FILE main.c:
#include "myHead.h"

int main () {

	int i;
	int n;
	int result;
	int *p = NULL;
	int **div = NULL;
	int **minNum = NULL;

	scanf("%d", &n);
	p = (int *)malloc(sizeof(int) * (n + 1));
	for (i = 0; i <= n; i++) {
		scanf("%d", &p[i]);
	}
	minNum = (int **)malloc(sizeof(int) * (n+1));
	div = (int **)malloc(sizeof(int) * (n+1));
	for (i = 0; i < n; i++) {
		minNum[i] = (int *)malloc(sizeof(int) * (n+1));
		div[i] = (int *)malloc(sizeof(int) * (n+1));
	}

	result = matrixChain(p, n, minNum, div);
	printf("%s%d\n", "Minimum times: ", result);
 	printMatrixChain(0, n - 1, div);
 	printf("\n");

	return 0;

}
/*
// ````````````````````````````````````````
// FILE myHead.h:
#include <stdio.h>
#include <stdlib.h>

int matrixChain(int *p, int n, int **minNum, int **div);
void printMatrixChain(int i, int j, int **div);
void printMatrix(int *p, int n);

#include "source.c"

// ````````````````````````````````````````
// FILE source.c:
#define MAX 100000

int matrixChain(int *p, int n, int **minNum, int **div) {

	int i;
	int j;
	int k;
	int num;

	// The result of matrix member muls itself are all zero.
	for (i = 0; i < n; i++) {
		minNum[i][i] = 0;
	}

	// Originally, the length of the matrix chain is 2.
	for (num = 2; num <= n; num++) {
		for (i = 0; i <= (n - num); i++) {
			j = i + num - 1;
			minNum[i][j] = MAX;
			for (k = i; k <= j - 1; k++) { // k means the place to divide.
				int temp = minNum[i][k] + minNum[k + 1][j] + p[i] * p[k + 1] * p[j + 1];
				if (temp < minNum[i][j]) {
					//printf("%d %d, %d %d\n", i, k, temp, minNum[i][j]);
					minNum[i][j] = temp;
					div[i][j] = k;
				}
			}
		}
		if (num == n) {
			break;
		}
	}

	return minNum[0][n - 1];

}

void printMatrixChain(int i, int j, int **div) {

	if (i == j) {
		printf("%s%d", "A", i + 1);
	} else {
		printf("(");
		printMatrixChain(i, div[i][j], div);
		printMatrixChain(div[i][j] + 1, j, div);
		printf(")");
	}

}

void printMatrix(int *p, int n) {

	int i;
	for (i = 0; i < n; i++) {
		printf("%d ", p[i]);
	}
	printf("\n");

}

// ````````````````````````````````````````

## 结果截图
*/