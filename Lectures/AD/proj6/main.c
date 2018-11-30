/*
# Nim游戏

## 题目描述
题目：Nim游戏
描述：现有n（随机整数）根火柴，两人轮流取，
每人每次可以取走1~4根（让电脑随机取），
不可多取，也不能不取，谁取最后一根火柴赢。
请编写一个程序模拟人机对弈。
输入：你的Choice（人先还是让电脑先）及你每次要拿去的火柴根数m。
输出：每一轮结果和最终输赢。

## 算法

分析：题目将Nim游戏规则中“棋子分堆”用“只能取1~4之间的棋子数”的形式简化，
相当于将n个棋子分成了n/4堆，算法中将讨论简化前的情况与简化后的情况。

简化前：
将所有堆的棋子转换成二进制，判断不进位的所有位进行加法运算后每位数字1的个数，如果1的个数等于0，则后手必胜，其余情况先手必胜。

简化后：
判断初始棋子总数与最大可取火柴数m的关系，如果n%(m+1)的关系成立，则后手必胜，其余情况先手必胜。

## 时间复杂度分析

## 输入输出

```
Amount of the matchs:26
You first(1) or Computer first(0)?
1
Now the amount of the matches is:26
Input how many matches you want to take: 1
Computer had taken 2 matches.
Now the amount of the matches is:23
Input how many matches you want to take: 3
Computer had taken 4 matches.
Now the amount of the matches is:16
Input how many matches you want to take: 1
Computer had taken 2 matches.
Now the amount of the matches is:13
Input how many matches you want to take: 3
Computer had taken 4 matches.
Now the amount of the matches is:6
Input how many matches you want to take: 1
Computer had taken 1 matches.
Now the amount of the matches is:4
Input how many matches you want to take: 4
You Win!
```

```
Amount of the matchs:20
You first(1) or Computer first(0)?
0
Computer had taken 2 matches.
Now the amount of the matches is:18
Input how many matches you want to take: 3
Computer had taken 2 matches.
Now the amount of the matches is:13
Input how many matches you want to take: 3
Computer had taken 1 matches.
Now the amount of the matches is:9
Input how many matches you want to take: 4
Computer had taken 3 matches.
Now the amount of the matches is:2
Input how many matches you want to take: 2
You Win!
```

```
Amount of the matchs:22
You first(1) or Computer first(0)?
0
Computer had taken 3 matches.
Now the amount of the matches is:19
Input how many matches you want to take: 2
Computer had taken 3 matches.
Now the amount of the matches is:14
Input how many matches you want to take: 2
Computer had taken 1 matches.
Now the amount of the matches is:11
Input how many matches you want to take: 4
Computer had taken 2 matches.
Now the amount of the matches is:5
Input how many matches you want to take: 1
Computer had taken 2 matches.
Now the amount of the matches is:2
Input how many matches you want to take: 1
Computer had taken 1 matches.
Computer Win!
```

## 源代码

*/

#include "myHead.h"

int main() {
	int choice = 0;
	int n = 0;

	n = init();

	printf("%s%d\n", "Amount of the matchs:", n);
	printf("%s\n", "You first(1) or Computer first(0)?");
	scanf("%d", &choice);

	nim(n, choice);

	return 0;
}

/*
## 结果截图

*/