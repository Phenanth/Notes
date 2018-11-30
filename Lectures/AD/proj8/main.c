/*
# 最近点对问题

## 题目描述
题目：最近点对
描述：给定二维空间中n个点，请写出效率尽量高的算法找出它们中的最近点对。
输入：点数n
输出：最近两个点的坐标

## 算法

分治法：
1. 将n个点按照x坐标进行排序。进入第二步。
2. 以坐标mid为界限将所有坐标分成左右两个部分，对左右两部分分别求最近点对的距离。进入第三步。
3. 对左右两部分进行合并。对于两个部分求得的最近距离d。进入第四步。
4. 合并过程中检查宽为2d的区间中是否有两个点分别属于两个集合并且距离小于d，进入第五步。
5. 分别对宽为2d的带状区间的左右两部分按照y坐标进行排序。进入第六步。
6. 由于稀疏性质对于左边的任意一个点右边只需要最多检查六个点，找到最短距离的两点。进入第七步。
7. 将子区域的最短距离回到递归上级并重复直至所有区域都被合并。

## 时间复杂度分析

分治法：
由于分治法每次对区域进行二分，且在合并步骤中存在鸽巢原理，
只需要线性的时间就能检查带状区间是否存在最近点，
于是蛮力法的时间复杂度O(n^2)被简化为O(nlogn)

## 输入输出

**注意**：编译语句：`gcc main.c -lm`链接`math.h`头文件。

```
15
```

```
Random generated point set:
(59, 42) (29, 19) (65, 53) (98, 19) (61, 25) (45, 91) (79, 2) (11, 47) (61, 18) (68, 44) (25, 71) (80, 97) (62, 70) (46, 13) (93, 75) 
The closet two points are having distance: 7.000
Two points are: 
(61, 25) (61, 18)
```

```
8
```

```
Random generated point set:
(97, 26) (33, 47) (88, 38) (63, 11) (36, 62) (75, 9) (7, 56) (58, 54) 
The closet two points are having distance: 12.166
Two points are: 
(63, 11) (75, 9) 
```

```
3
```

```
Random generated point set:
(63, 76) (74, 36) (24, 39) 
The closet two points are having distance: 41.485
Two points are: 
(74, 36) (63, 76)
```

## 源代码
*/
// FILE main.c:
#include "myHead.h"

int main() {

	int n = 0;
	double dmin = -1;
	POINTPOINTER arr = NULL;
	POINTPOINTER result = NULL;

	scanf("%d", &n);
	arr = generatePoints(n);

	printf("%s\n", "Random generated point set:");
	printArray(arr, n);
	result = closestTwoPoints(arr, 0, n - 1, &dmin);
	printf("%s%.3lf\n", "The closet two points are having distance: ", dmin);
	printf("%s\n", "Two points are: ");
	printArray(result, 2);

	return 0;

}
/*
// ````````````````````````````````````````
// FILE myHead.h:

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

// ````````````````````````````````````````
// FILE source.c:

## 结果截图


*/