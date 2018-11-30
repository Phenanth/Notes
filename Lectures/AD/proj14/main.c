/*
# 活动安排问题

## 问题描述
题目：活动安排问题。
描述：有n个活动的集合E-{1, 2, ..., n}，
要求使用同一资源，如演讲会场、教室安排等等。
而在同一时间内只有一个活动能使用这一资源。
第i个活动要求使用的起始时间和结束时间分别是si、fi，si<fi。
如果si>fj或者sj>fi，则称活动i与活动j为相容的。
活动安排问题就是要在所给的活动集合中选出最大
（活动个数最多）的相容活动子集。
输入：包含n个活动的活动集合。
输出：活动个数最多的相容子集。

## 算法
贪心法：
1. 对各个活动根据活动结束时间进行增序排序。进入第二步。
2. 从集合中选取当前活动时长最小的活动并与现存活动进行比较，可行则进入第三步，否则进入第四步。
3. 从集合中删去被选中的活动，进入第四步。
4. 检查集合中是否还有未检查过的活动，有则进入第二步，无则结束算法。

## 时间复杂度
贪心法：
贪心法的时间复杂度主要依赖于比较前的排序耗费的时间，而挑选算法本身的时间复杂度依赖于
对排序后的活动集合进行遍历的速度，是线性的，为O(n)

## 输入输出

```
11
3 5
1 4
3 8
0 6
5 9
6 10
8 12
2 13
5 7
12 14
8 11
```
```
After sort:
Event 0: 1 4
Event 1: 3 5
Event 2: 0 6
Event 3: 5 7
Event 4: 3 8
Event 5: 5 9
Event 6: 6 10
Event 7: 8 11
Event 8: 8 12
Event 9: 2 13
Event 10: 12 14

Selected events:
Event 0: 1-4
Event 3: 5-7
Event 7: 8-11
Event 10: 12-14
```

## 
*/
#include "myHead.h"

int main () {

	int n;
	int nrst;
	EVENTPOINTER events;
	int *result;

	events = Init(&n);

	result = ActivitySelector(events, n, &nrst);
	printResult(events, result, nrst);
	
	return 0;

}

/*
## 结果截图

*/