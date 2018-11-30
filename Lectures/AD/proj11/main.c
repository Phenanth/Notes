/*
# 找零问题

## 题目描述
题目：找零问题。
描述：需找零金额为n，最少要用多少面值为d1<d2<d3<....<dn的硬币？
输入：需找零金额n。
输出：总金额为n的硬币最少的数目。

## 算法

动态规划：
1. 初始dj为0，且F(n)为0。进入第二步。
2. 判断当前金额数是否不大于n，若大于n则结束遍历。进入第三步。
3. 选择使总金额减去某币值后，最小的金额总数对应的硬币总数并加1，作为此步的硬币数。进入第二步。

## 时间复杂度分析

动态规划：
该算法的效率依赖于金额总数n与硬币面值数目m。
且算法进行过程中，每一个减去货币最小单位的总金额数都会根据每一个币值进行遍历以寻找最少硬币数。
于是算法的时间复杂度为O(mn)。

## 输入输出
```
6
```
```
The minimum amount of coins is: 2
```

```
10
```
```
The minimum amount of coins is: 3
```

## 源代码

*/
// FILE main.c:
#include "myHead.h"

int main() {

	int n;
	int result;
	int *coins;

	init(&coins, &n);
	result = changeMaking(coins, n);

	printf("%s%d\n", "The minimum amount of coins is: ", result);

	return 0;
	
}
/*
// ``````````````````````````````````````
// FILE myHead.h:

#include <stdio.h>
#include <stdlib.h>

int changeMaking(int *coin, int n);
void init(int **coins, int *n);

#include "source.c"

// ``````````````````````````````````````
// FILE source.c:

// The amount of the different  type of coins.
#define TYPES 3
// The number acts as infinite.
#define MAX 50000

// Making the changes.
int changeMaking(int *coins, int n) {

	int i;
	int *temp;

	temp = (int *)malloc(sizeof(int) * (n + 1));
	temp[0] = 0;

	for (i = 1; i <= n; i++) {
		int j = 0;
		int min = MAX;

		// When the money is enough,
		// and not all of the types are traversaled.
		while (j < TYPES && i >= coins[j]) {
			int index;
			index = i - coins[j];
			min = temp[index] < min ? temp[index] : min;
			j += 1;
		}

		temp[i] = min + 1;
	}

	return temp[n];

}

// Initilization
void init(int **coins, int *n) {

	scanf("%d", n);
	*coins = (int *)malloc(sizeof(int) * TYPES);
	(*coins)[0] = 1;
	(*coins)[1] = 3;
	(*coins)[2] = 4;

}
// ``````````````````````````````````````

## 结果截图

*/
