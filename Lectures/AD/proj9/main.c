/*
# 高斯消元

## 问题描述
题目：高斯消元法解决开关问题。
描述：
有N个相同的开关，每个开关都与某些开关有着联系，每当你打开或者关闭某个开关的时候，
其他的与此开关相关联的开关也会相应地发生变化，即这些相联系的开关的状态如果原来为开就变为关，
如果为关就变为开。你的目标是经过若干次开关操作后使得最后N个开关达到一个特定的状态。
对于任意一个开关，最多只能进行一次开关操作。
你的任务是，计算有多少种可以达到指定状态的方法。（不计开关操作的顺序）
输入：
输入第一行有一个数K，表示以下有K组测试数据。 
每组测试数据的格式如下： 
第一行 一个数N（0 < N < 29） 
第二行 N个0或者1的数，表示开始时N个开关状态。 
第三行 N个0或者1的数，表示操作结束后N个开关的状态。 
接下来 每行两个数I J，表示如果操作第 I 个开关，第J个开关的状态也会变化。每组数据以 0 0 结束。
输出：如果有可行方法，输出总数，否则输出“Oh,it's impossible~!!” 不包括引号。

## 算法

变治法：
算法的核心是将问题简化为本质不变的一个更简单的问题，
这里是将开关互相影响的关系转化为矩阵的表示方法，并用高斯消元法对矩阵进行初等行变换，
并观察最终矩阵形态来判断问题是否有解。
1. 将输入转化为矩阵表示方法，扩展一列目标状态为增广矩阵。进入第二步。
2. 对矩阵进行初等行变换，化成阶梯形。进入第三步。
3. 判断问题是否存在解，即矩阵是否有[0,0,...,0,1]的行，有则无解。有解进入第四步。
4. 判断[0,0,0,...,0]行的存在数目r。r为0则问题有唯一解，否则有2^r组解。

## 时间复杂度分析

变治法：
高斯消元法对矩阵进行初等行变换需要决定作为减行的基行，然后对整个矩阵进行遍历，时间复杂度为O(n^3)。

## 输入输出

**注意**：编译语句：`gcc main.c -lm`链接`math.h`头文件。
```
2
3
0 0 0
1 1 1
1 2
1 3
2 1
2 3
3 1
3 2
0 0
3
0 0 0
1 0 1
1 2
2 1
0 0
```
```
4
Oh,it's impossible~!!
```

## 源代码
*/
// FILE main.c:
#include "myHead.h"

int main() {

	int group = 0;
	int n; // row
	int **arr;
	int **result;

	scanf("%d", &group);
	while (group--) {
		arr = init(&n);
		result = forwardElimination(arr, n);
		printResult(result, n, group);
	}

	return 0;
}

/*
// ``````````````````````````````````````
// FILE myHead.h:
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

// ``````````````````````````````````````
// FILE source.c:
// Gauss algorithm.
int **forwardElimination(int **arr, int row) {

	int i, j, k;

	for (i = 0; i < row; i++) {
		for (j = i + 1; j < row; j++) {
			for (k = row; k > i - 1; k--) {
				if (arr[i][i]) {
					arr[j][k] = arr[j][k] - arr[i][k] * arr[j][i] / arr[i][i];
				}
				else {
					arr[j][k] = 0;
				}
				//printArray(arr, row);
			}
		}
	}

	return arr;

}

int switchRow(int **arr, int row, int n) {
	int i, j, flag = 0;
	for (i = 0; i < n; i++) {
		if (i != row && arr[i][i] != 0) {
			for (j = 0; j < n + 1; j++) {
				int temp;
				temp = arr[row][j];
				arr[row][j] = arr[i][j];
				arr[i][j] = temp;
			}
			flag = 1;
			break;
		}
	}
	return flag;
}

void printResult(int **arr, int row, int flag) {

	int i, j, non = 0, ctn = 0;

	// Should check if gause algorithm will return a formated array.
	// Or else I need to optimize the way answer is checked.
	// Also need to check if this function can cover all the posibilities.
	for (i = 0; i < row; i++) {
		int allZero = 1;
		int allZeroExpt = 1;
		for (j = 0; j < row + 1; j++) {
			if (arr[i][j] != 0) {
				allZero = 0;
				if (j != row) {
					allZeroExpt = 0;
				}
				else {
					break;
				}
			}
			else if (arr[i][j] == 0 && j == row) {
				allZeroExpt = 0;
			}
		}
		if (allZeroExpt) {
			non = 1;
			break;
		}
		if (allZero) {
			ctn++;
		}
	}

	if (non) {
		printf("%s", "Oh,it's impossible~!!");
	}
	else if (ctn == 0) {
		printf("%d", ctn + 1);
	}
	else {
		printf("%.0lf", pow(2.0, (double)ctn));
	}

	if (flag) {
		printf("\n");
	}

}

int **init(int *n) {

	int i, j;
	int *alt, *alt1, *alt2;
	int **temp;
	int a, b;

	scanf("%d", n);
	alt = (int *)malloc(sizeof(int) * (*n));
	alt1 = (int *)malloc(sizeof(int) * (*n));
	alt2 = (int *)malloc(sizeof(int) * (*n));
	temp = (int **)malloc(sizeof(int *)*(*n));
	for (i = 0; i < *n; i++) {
		temp[i] = (int *)malloc(sizeof(int) * (*n + 1));
	}

	// Initilize the array with 0.
	for (i = 0; i < *n; i++) {
		for (j = 0; j < (*n + 1); j++) {
			temp[i][j] = 0;
		}
	}

	// Each switch can effect it self.
	for (i = 0; i < *n; i++) {
		temp[i][i] = 1;
	}

	// Generate the altered result.
	for (i = 0; i < *n; i++) {
		scanf("%d", &(alt1[i]));
	}
	for (i = 0; i < *n; i++) {
		scanf("%d", &(alt2[i]));
	}
	for (i = 0; i < *n; i++) {
		alt[i] = (alt1[i] == 1 && alt2[i] == 0) || (alt1[i] == 0 && alt2[i] == 1);
	}

	// Add relationship between switches.
	do {
		scanf("%d %d", &a, &b);
		if (a == 0 && b == 0) {
			break;
		}
		temp[a - 1][b - 1] = 1;
	} while (1);

	// Altered array.
	// If needed, cut this part and paste in the gause algorithm.
	for (i = 0; i < *n; i++) {
		temp[i][(*n)] = alt[i];
	}

	return temp;

}

void printAlt(int *arr, int row) {
	int i;
	for (i = 0; i < row; i++) {
		printf("%d ", arr[i]);
	}
	printf("\n");
}

void printArray(int **arr, int row) {
	int i, j;
	for (i = 0; i < row; i++) {
		for (j = 0; j < row + 1; j++) {
			printf("%d ", arr[i][j]);
		}
		printf("\n");
	}
	printf("\n");
}


## 结果截图

*/
