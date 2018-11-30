
/*
# 全排列问题

## 题目描述

题目：全排列问题
描述：给出一个数字n，输出集合{1, 2, ..., n}中所有数字的排列方式。
输入：1, 2, 3, 4（四个数字）
输出：24种全排列

## 算法

减治法：
1. 若数字n等于1，直接输出数字1，否则进入第二步。
2. 若数字n大于等于2，递归调用获取n-1的全排列，进入第三步。
3. 从右到左把n插入12...(n-1)的序列中，每处理一个{1, 2, ..., n-1}的新排列时调换方向。

Johnson-Trotter算法：
1. 将第一个排列初始化为有方向的序列123...n。
2. 判断是否存在大于箭头指向方向的相近数字的数字，有则进入第三步，无则退出循环。
3. 求出第二步中形容的最大的可移动数字k，进入第四步。
4. 将k与它箭头指向的相邻元素互换位置，进入第五步。
5. 调转所有大于k的元素的方向，进入第六步。
6. 将新的排列加入到列表中，回到第二步。

## 时间复杂度分析

减治法：
减治法每次选出一个数字作为第一个数字，然后对剩下的元素求全排列，做（n-1）的阶乘的排列，
所以时间复杂度为O(n!)。

Johnson-Trotter算法：
由于该算法每次为了生成新的排列都需要产生(n-1)的阶乘个中间排列，
所以它的时间复杂度是效率十分低的O(n!)。

## 输入与输出

```
3
```
```
Using Decrease and Conquer:
321
231
213
312
132
123
Using Another Decrease and Conquer:
123
132
213
231
312
321
Using Johnson-Trotter:
123
132
312
321
231
213
```

```
4
```
```
Using Decrease and Conquer:
4321
3421
3241
3214
4231
2431
2341
2314
4213
2413
2143
2134
4312
3412
3142
3124
4132
1432
1342
1324
4123
1423
1243
1234
Using Another Decrease and Conquer:
1234
1243
1324
1342
1423
1432
2134
2143
2314
2341
2413
2431
3124
3142
3214
3241
3412
3421
4123
4132
4213
4231
4312
4321
Using Johnson-Trotter:
1234
1243
1423
4123
4132
1432
1342
1324
3124
3142
3412
4312
4321
3421
3241
3214
2314
2341
2431
4231
4213
2413
2143
2134
``

## 源代码

*/
// FILE main.c:
#include "myHead.h"


int main () {

	int n, i, j, **result;

	scanf("%d", &n);
	init(n);
	
	printf("%s\n", "Using Decrease and Conquer:");
	result = fnDecrease_1(n);
	printArray(result, n);
	
	
	printf("%s\n", "Using Another Decrease and Conquer:");
	fnDecrease_2(0, n);

	printf("%s\n", "Using Johnson-Trotter:");
	result = fnJohnsonTrotter(n);
	printArray(result, n);

	return 0;

}

/*
// ````````````````````````````````````````````
// FILE myHead.h:
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

// `````````````````````````````````````````````
// FILE source1.c:
// Decrese and Conquer algorithm.
int **fnDecrease_1(int n) {
	int **arr, t = Factorial(n), i;

	arr = initArray(n);

	if (n == 1) {
		arr[0][0] = 1;
	} else {
		int **temp, *tmp, index, i, j, k, p, len = 1;
		temp = fnDecrease_1(n - 1);
		tmp = (int *)malloc(sizeof(int) * (n - 1));

		index = 0;

		for (i = 1; i <= (n - 1); i++) {
			len *= i;
		}

		for (i = 0; i < len; i++) {
			tmp = temp[i];
			for (j = 0; j < n; j++) {
				arr[index][j] = n;
				for (k = 0, p = 0; k < n && p < (n - 1); k++) {
					if (arr[index][k] != n) {
						arr[index][k] = tmp[p];
						p++;
					}
				}
				index++;
			}
		}
	}
	return arr;
}

// ```````````````````````````````````````````
// FILE source2.c:
// Johnson-Trotter algorithm.
int **fnJohnsonTrotter(int n) {

	int **arr, *dir, *tmp, i, t = Factorial(n), pos = 1;

	arr = initArray(n);
	for (i = 0; i < n; i++) {
		arr[0][i] = i + 1;
	}

	dir = (int *) malloc(sizeof(int) * n);
	tmp = (int *)malloc(sizeof(int) * n);
	for (i = 0; i < n; i++) {
		tmp[i] = arr[0][i];
	}

	while (notCompleted(tmp, dir, n)) {
		int maxOne = maxOneInArray(tmp, dir, n), index = 0;
		for (i = 0; i < n; i++) {
			if (tmp[i] == maxOne) {
				index = i;
			}
		}

		if (dir[index] == 0) {
			int temp;
			temp = tmp[index - 1];
			tmp[index - 1] = tmp[index];
			tmp[index] = temp;
			dir[index] = dir[index - 1];
			dir[index - 1] = 0;
		} else if (dir[index] == 1) {
			int temp;
			temp = tmp[index + 1];
			tmp[index + 1] = tmp[index];
			tmp[index] = temp;
			dir[index] = dir[index + 1];
			dir[index + 1] = 1;
		}

		for (i = 0; i < n; i++) {
			if (tmp[i] > maxOne) {
				if (dir[i] == 1) {
					dir[i] = 0;
				} else {
					dir[i] = 1;
				}
			}
		}

		for (i = 0; i < n; i++) {
			arr[pos][i] = tmp[i];
		}
		pos++;

	}

	return arr;

}

// Find if there is any numbers can be moved.
int notCompleted(int *tmp, int *dir, int n) {
	int i;
	for (i = 0; i < n; i++) {
		if (i != 0 && dir[i] == 0) {
			if (tmp[i] > tmp[i - 1]) {
				return 1;
			}
		}
		if (i != (n - 1) && dir[i] == 1) {
			if (tmp[i] > tmp[i + 1]) {
				return 1;
			}
		}
	}
	return 0;
}

// Find the number which is both the biggest and can be moved.
int maxOneInArray(int *tmp, int *dir, int n) {
	int i, max = 0;
	for (i = 0; i < n; i++) {
		if (i != 0 && dir[i] == 0) {
			if (max < tmp[i] && tmp[i] > tmp[i - 1]) {
				max = tmp[i];
			}
		}
		if (i != (n - 1) && dir[i] == 1) {
			if (max < tmp[i] && tmp[i] > tmp[i + 1]) {
				max = tmp[i];
			}
		}
	}
	return max;
}

// ``````````````````````````````````````
// FILE source.c:
// Another Decrease and Conquer algorithm.
void fnDecrease_2(int n, int tot) {

	int i;
	//  When all four numbers has a new order, print it.
	if (n == tot) {
		for (i = 0; i < tot; i++) {
			if ((i+1) % (tot) == 0) {
				printf("%d\n", a[i]);
			} else {
				printf("%d", a[i]);
			}
		}
	}
	// Backtracking when all four numbers are visited, or call the function itself.
	for (i = 0; i < tot; i++) {
		if (visit[i] == 0) {
			visit[i] = 1;
			a[n] = i + 1;
			fnDecrease_2(n + 1, tot);
			visit[i] = 0;
		}
	}

}

// Calculate the factorial result.
int Factorial(int n) {

	int i, result;

	for (i = 1, result =1; i <= n; i++) {
		result *= i;
	}

	return result;

}

// Initilization of the array using in decrease algorithm.
void init(int n) {

	int i;

	a = (int *)malloc(sizeof(int) * n);
	visit = (int *)malloc(sizeof(int) * n);

	for (i = 0; i < n; i++) {
		a[i] = i + 1;
		visit[i] = 0;
	}

}

// Apply memory space for the array.
int **initArray(int n) {

	int i, t = Factorial(n), **arr;

	arr = (int **)malloc(sizeof(int *) * t);
	for (i = 0; i < t; i++) {
		arr[i] = (int *)malloc(sizeof(int ) * n);
	}

	return arr;

}

// Print the result array.
void printArray(int **result, int n) {

	int i, j, t = Factorial(n);

	for (i = 0; i < t; i++) {
		for (j = 0; j < n; j++) {
			printf("%d", result[i][j]);
		}
		printf("\n");
	}

}

// `````````````````````````````````````````

## 结果截图

*/