/*
# 平面凸包问题

## 题目描述

题目：给出平面内几个点，求出它们的凸包。
描述：算法要求画图验证正确性，直线方程计算选择直线方程法或者向量叉乘方法（二选一）。
输入：点个数n，几个点(x1, y1),...,(xn,yn)。
输出：覆盖这几个点的凸包。

## 算法

蛮力法：
1. 对n个点集合中的任一两个不重复的点pi与pj生成连线ln。
2. 判断其余n-2个点是否都在这条连线的一边，满足做3，不满足做4。
3. 输出连线ln的两个端点pi与pj，做第四步。
4. 更换pi或pj坐标，如果点集中所有点都被遍历则停止算法，否则回到第一步。

注意点：首先要注意pi与pj的取值不能相同，也不能是已经遍历过的点。
（嵌套for循环中，代表列的下标要大于代表行的）。

## 时间复杂度分析

由于蛮力法需要对点集中任一两点形成的直线进行其余n - 2个点的遍历，
生成一条直线需要做O(n^2)的遍历，对于每条直线，又要遍历剩下的n - 2个点，
经过分析，蛮力法算法的时间复杂度为O(n^3)。

## 输入与输出

输入格式：
第一行为点集中点的个数n，接下来的n行每行有两个整形来代表一个点，
第一个整形为点的横坐标x，第二个整形为点的纵坐标y。
程序会对输入进行提示，输入文件参见`input.txt`。

输入1：
```
4
1 4
2 6
7 3
4 4
```
输出1：
```
The edges that presents the convex hull of the points are:
(1, 4) -> (2, 6)
(1, 4) -> (7, 3)
(2, 6) -> (7, 3)
```

输入2：
```
5
1 2
2 1
2 2
2 5
4 2
```
输出2：
```
The edges that presents the convex hull of the points are:
(1, 2) -> (2, 1)
(1, 2) -> (2, 5)
(2, 1) -> (4, 2)
(2, 5) -> (4, 2)

```

输入3：
```
6
1 1
5 1
1 6
5 6
3 3
3 4
```
输出3：
```
The edges that presents the convex hull of the points are:
(1, 1) -> (5, 1)
(1, 1) -> (1, 6)
(5, 1) -> (5, 6)
(1, 6) -> (5, 6)
```

## 源代码
```
*/
// FILE main.c:
#include "myHead.h"

int main() {

	int i = 0, j = 0, n;
	POINTPOINTER arr;

	arr = init(&n);
	printf("%s\n", "The edges that presents the convex hull of the points are:");

	for (i = 0; i < n; i++) {
		for (j = i + 1; j < n; j++) {
			if (isAllSameSide(arr, n, i, j)) {
				printf("(%d, %d) -> (%d, %d)\n", arr[i].x, arr[i].y, arr[j].x, arr[j].y);
			}
		}
	}

	return 0;

}

// ```````````````````````````````````````````
/*
// FILE myHead.h:
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

// ```````````````````````````````````````````
// FILE source.c
// Judge if all the points are in the same side of a line.
int isAllSameSide(POINTPOINTER arr, int n, int i, int j) {

	int x1 = arr[i].x, y1 = arr[i].y, x2 = arr[j].x, y2 = arr[j].y;
	int a = y2 - y1, b = x1 - x2, c = x1 * y2 - y1 * x2;
	int m = 0, index = 0, REAL = 1, first = 1;

	for (m = 0; m < n; m++) {
		if (m != i && m != j) {
			if (!isSameSide(a, b, c, arr[m].x, arr[m].y, &index, &first)) {
				REAL = 0;
				break;
			}
		}
	}

	if (!REAL) {
		return 0;
	} else {
		return 1;
	}

}

// Judge if one single point is in the same side. 
int isSameSide(int a, int b, int c, int x, int y, int* index, int* first) {

	if (*first == 1) {
		*index = (a * x + b * y >= c);
		*first = 0;
		return 1;
	}

	if ((a * x + b * y >= c) == *index) {
		return 1;
	} else {
		return 0;
	}

}

// Initilization of the set of the points.
POINTPOINTER init(int* n) {

	int i = 0;
	POINTPOINTER arr;

	printf("%s\n", "The numbers of the points is:");
	scanf("%d", n);

	arr = (POINTPOINTER) malloc(*n * sizeof(struct point));
	
	printf("%s\n", "The points are:");

	for (i = 0; i < *n; i++) {
		scanf("%d %d", &(arr[i].x), &(arr[i].y));
	}

	return arr;

}

// Print the array, for debugging.
void printArray(POINTPOINTER arr, int n) {

	int i = 0;

	for (i = 0; i < n; i++) {
		printf("(%d, %d)\n", arr[i].x, arr[i].y);
	}

}

// ```````````````````````````````````````````
```

## 结果截图

*/
