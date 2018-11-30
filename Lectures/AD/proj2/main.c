/*
# 汉诺塔问题

## 题目描述

题目：汉诺塔实现
描述：有A，B，C三根柱子，通过B柱，将N个盘子从A柱移至C柱，要求小盘子在大盘子上面。
输入：输入一个整数，代表N。
输出：输出打印移动的所有步骤。

## 算法

迭代算法：
1. 将N - 1个盘子从A柱移动到B柱（借助C柱）
2. 将A柱上最大的盘子移动到C柱
3. 将B柱的N - 1个盘子移动到C柱（借助A柱）

## 时间复杂度分析

由于算法核心是用到了迭代的思想，移动的次数依赖于盘子的个数n。
分析如下：
当n = 1时，M(1) = 1。
当n > 1时，移动次数M(n) = 2M(n - 1) + 1。 
则用反向替换法经过i次替换后：
M(n) = 2^i * M(n - i) + 2^i - 1。
由于初始条件为n = 1时，M(1) = 1，又可得到以下递推式：
M(n) = 2^(n - 1) * M(1) + 2^(n - 1) - 1 = 2^(n) - 1。
则可以得到结论：汉诺塔问题的迭代算法的时间复杂度为O(2^n)，效率较低。

## 输入与输出

输入1：
```
3
```
输出1：
```
A -> C
A -> B
C -> B
A -> C
B -> A
B -> C
A -> C
```

输入2：
```
4
```
输出2：
```
A -> B
A -> C
B -> C
A -> B
C -> A
C -> B
A -> B
A -> C
B -> C
B -> A
C -> A
B -> C
A -> B
A -> C
B -> C
```

输入3：
```
5
```
输出3：
```
A -> C
A -> B
C -> B
A -> C
B -> A
B -> C
A -> C
A -> B
C -> B
C -> A
B -> A
C -> B
A -> C
A -> B
C -> B
A -> C
B -> A
B -> C
A -> C
B -> A
C -> B
C -> A
B -> A
B -> C
A -> C
A -> B
C -> B
A -> C
B -> A
B -> C
A -> C
```


## 源代码

```
*/
// FILE main.c:
#include "myHead.h"

int main() {

	int n = 0;

	do {
		scanf("%d", &n);
	} while (n < 1 || n > 10);

	Hanoi(n, 'A', 'B', 'C');

	return 0;
	
}

// ````````````````````````````````````````
/*
// FILE myHead.c:
#include <stdio.h>
#define MAX 10

// FILE source.c:
void Hanoi(int n, char a, char b, char c);

#include "source.c"

// ````````````````````````````````````````
// FILE source.c:
void Hanoi(int n, char a, char b, char c) {

	if (n == 1) {
		printf("%c -> %c\n", a, c);
		return;
	}

	Hanoi(n - 1, a, c, b);
	printf("%c -> %c\n", a, c);
	Hanoi(n - 1, b, a, c);

}

```

## 结果截图

*/
