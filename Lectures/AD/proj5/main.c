/*
# 八皇后问题

## 题目描述
题目：八皇后问题
描述：8 * 8 的棋盘，摆放8个皇后，互不攻击。
输入：无输入
输出：输出无冲突的八皇后摆放位置。

## 算法
蛮力法：
1. 在一行的一格上放下一个皇后（初始位置为第一行与第一列），进入第二步。
2. 当行数等于八时，进入第三步，否则先判断格数等于八时，行数加一；再判断当格数小于八时，格数加一；。回到第一步。
3. 判断目前棋盘是否符合八皇后规则，成立则打印棋盘。不成立则：当行数格数都为八时退出循环，否则当格数小于八时格数加一，进入第一步；格数等于八时行数减一，进入第一步。。

回溯法：
1. 在此行（初始为第一行）的一个格子上放下一个皇后，放下后若无冲突进入第二步，若有冲突进入第三步。
2. 若此时行数小于八，行数加一，回到第一步；若行数等于八，输出此时棋盘状况，结束此棋盘循环。
3. 收回放下的皇后。回到上一行，若此时格数小于八，格数加一，进入第一步。若格数大于八，行数加一，进入第一步。

## 时间复杂度分析

蛮力法：
蛮力法使用n个嵌套的遍历循环，显而易见的时间复杂度为O(n^n)，与n成指数次的增长速度，效率很低。

回溯法：
回溯法可以理解成是每放下一个棋子，棋盘的每一行上都少了一个需要判断的位置，
也就是搜索树上都少了一个分支，通过回溯法的剪枝的性质，可以预测到回溯法的时间复杂度为
O(n!)。

## 输入输出

输入：无输入
输出：部分输出
```
Force Algorithm:
Method 1:
1 5 8 6 3 7 2 4 
Method 2:
1 6 8 3 7 4 2 5 
Method 3:
1 7 4 6 8 2 5 3 
Method 4:
1 7 5 8 2 4 6 3 
Method 5:
2 4 6 8 3 1 7 5 
（中间省略）
Method 89:
8 2 4 1 7 5 3 6 
Method 90:
8 2 5 3 1 7 4 6 
Method 91:
8 3 1 6 2 5 7 4 
Method 92:
8 4 1 3 6 2 7 5 

Recursive Algorithm:
Method 1:
1 5 8 6 3 7 2 4 
Method 2:
1 6 8 3 7 4 2 5 
Method 3:
1 7 4 6 8 2 5 3 
Method 4:
1 7 5 8 2 4 6 3 
Method 5:
2 4 6 8 3 1 7 5 
（中间省略）
Method 87:
7 4 2 8 6 1 3 5 
Method 88:
7 5 3 1 6 8 2 4 
Method 89:
8 2 4 1 7 5 3 6 
Method 90:
8 2 5 3 1 7 4 6 
Method 91:
8 3 1 6 2 5 7 4 
Method 92:
8 4 1 3 6 2 7 5
```


## 源代码

*/
// FILE main.c:
#include "myHead.h"

int main() {


	init();

	printf("%s\n", "Force Algorithm:");
	Queen_Force();

	clear(0);
	count = 0;

	printf("%s\n", "Recursive Algorithm:");
	Queen_Recur(0);

	return 0;

}
/*
// ``````````````````````````````````````````
// FILE myHead.c:
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

// ``````````````````````````````````````````
// FILE source.c:
// Initilization of the result array.
void init() {

	int i;
	result = (int *)malloc(sizeof(int) * NUM);

	for (i = 0; i < NUM; i++) {
		result[i] = 0;
	}

}

// Clear the result array.
void clear(int index) {

	int i;

	for (i = index; i < NUM; i++) {
		result[i] = 0;
	}

}

// Print the result array.
void printResult() {

	int i;

	printf("%s%d:\n","Method ", count);
	for (i = 0; i < NUM; i++) {
		printf("%d ", result[i]);
	}

	printf("\n");

}

// Judge the whole finished array.
int fnJudge(int num) {

	int i;
	for (i = 0; i < num; i++) {
		if (!fnRowJudge(i)) {
			return 0;
		}
	}

	return 1;

}

// Judge one row of the array.
int fnRowJudge(int row) {

	int i;
	for (i = 0; i < row; i++) {
		if (result[i] == result[row] || abs(result[i] - result[row]) == abs(i - row)) {
			return 0;
		}
	}
	return 1;

}

// ``````````````````````````````````````````
// FILE source1.c:
// Force algorithm.
void Queen_Force() {
	int a, b, c, d, e, f, j, h;

	for (a = 1; a <= NUM; a++) {
		result[0] = a;
		for (b = 1; b <= NUM; b++) {
			result[1] = b;
			for (c = 1; c <= NUM; c++) {
				result[2] = c;
				for (d = 1; d <= NUM; d++) {
					result[3] = d;
					for (e = 1; e <= NUM; e++) {
						result[4] = e;
						for (f = 1; f <= NUM; f++) {
							result[5] = f;
							for (j = 1; j <= NUM; j++) {
								result[6] = j;
								for (h = 1; h <= NUM; h++) {
									result[7] = h;
									if (fnJudge(NUM)) {
										count++;
										printResult();
									}
								}
							}
						}
					}
				}
			}
		}
	}

}

// ``````````````````````````````````````````
// FILE source2.c:
// Recursive algorithm.
void Queen_Recur(int row) {

	int i;

	if (row == NUM) {
		count++;
		printResult();
		return ;
	}

	for (i = 0; i < NUM; i++) {
		result[row] = i + 1;
		if (fnRowJudge(row)) {
			Queen_Recur(row + 1);
		}
	}

}

// ``````````````````````````````````````````

## 结果截图

*/
