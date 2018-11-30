/*
# 钢条切割问题

## 问题描述
题目：钢条切割问题
描述：给定一段长度为n的钢条和一个价格表pi，求切割钢条方案，使得销售收益rn最大。注意，如果长度为n的钢条的价格pn足够大，最优解可能就是完全不需要切割。
输入：钢条长度n。
输出：使销售收益rn最大的切割钢条方案。

## 算法
动态规划法：
1. 自底向上地生成各长度对应的最优销售收益。
2. 对n长度的钢条，判断各切割方案（包括不切割）的最优销售收益并保存。

## 时间复杂度
动态规划法：
由于需要对每一种长度的每一种切割方案都做判断，时间复杂度为O(n^2)，但比起递归调用的方法来说，系数要小得多。

## 输入输出
```
[skhr-mina@skhr-manjaro proj12]$ gcc main.c
[skhr-mina@skhr-manjaro proj12]$ ./a.out
Input a length between 1-10.
5
Max income:13
Resolution:2 3 
[skhr-mina@skhr-manjaro proj12]$ ./a.out
Input a length between 1-10.
7
Max income:18
Resolution:1 6 
```

## 源代码
*/
// FILE main.c:
#include "myHead.h"

int main () {

	int price[] = {1, 5, 8, 9, 10, 17, 17, 20, 24, 30};
	int temp[1] = { 0 };
	int *resolution;
	int result = 0, length = 0;

	do {
		printf("%s\n", "Input a length between 1-10.");
		scanf("%d", &length);
	} while (length > 10 || length < 1);

	resolution = cutRodDP(price, length, &result);
	if (!resolution) {
		resolution = temp;
	}
	printf("Max income:%d\nResolution:", result);
	while((*resolution) != 0) {
		printf("%d ", *resolution);
		resolution++;
	}
	printf("\n");
 
	return 0;
}
/*
// ````````````````````````````````````````````
// FILE myHead.h:
#include <stdio.h>
#include <stdlib.h>

int *cutRodPB(int *price, int length, int *result);
int isMax(int a, int b);

#include "source.c"

// ````````````````````````````````````````````
// FILE source.c:
#define MIN -10000

int *cutRodDP(int *price, int length, int *result) {

	int i, j;
	int *dp;
	int *temp;
	int *resolutionT;

	dp = (int *)malloc(sizeof(int) * (length + 1));
	resolutionT = (int *)malloc(sizeof(int) * (length));
	dp[0] = 0;
	for (i = 0; i< length; i++) {
		resolutionT[i] = 0;
	}

	// For each length, find the max income.
	for (i = 1; i <= length; i++) {
		int maxT = MIN;
		int count = 0;
		temp = (int *)malloc(sizeof(int) * i);
		for (j = 1; j <= i; j++) {
			if (maxT < dp[i - j] + price[j - 1]) {
				temp[0] = j;
				temp[1] = length - j;
				maxT = dp[i - j] + price[j - 1];
			} else {
				continue;
			}
		}
		resolutionT = temp;
		dp[i] = maxT;
	}

	*result = dp[length];
	return resolutionT;

}

int isMax(int a, int b) {
	return a > b ? a : b;
}
// ````````````````````````````````````````````

## 结果截图

*/