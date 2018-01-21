# DS_hw8

## Q1

(a) 

各点的出度与入度是：

出度
0: 0、1: 2、2: 2、3: 3、4: 1、5: 3

入度
0: 3、1: 2、2: 1、3: 1、4: 2、5: 2

(b)

该图的adjacency matrix是：


题头 | 点0 | 点1 | 点2 | 点3 | 点4 | 点5
---|---|---|---|---|---|---
**点0** | 0 | 0 | 0 | 0 | 0 | 0
**点1** | 1 | 0 | 0 | 1 | 0 | 0
**点2**| 0 | 1 | 0 | 0 | 0 | 1
**点3**| 0 | 0 | 1 | 0 | 1 | 1
**点4** | 1 | 0 | 0 | 0 | 0 | 0
**点5** | 1 | 1 | 0 | 0 | 1 | 0

(c) 

该图的 adjacency-list 表示方法是：




(d)

该图的 adjacency-multilist 表示方法是：



(e)

该图的强连通分量是：

由于强连通分量要求有向图的子图内每两个结点间都存在互达的路径，而图6.14中不存在这样的子图，故该图的强连通分量为图的每一个结点。


## Q2

```
#include <stdio.h>
#include <stdlib.h>
#define MAX 50

FILE *read;
short int vertexs, edges;
int **graph, visited[MAX];

// 生成数组
int **generateTemplate() {

	int **temp, i;
	temp = (int **)malloc(vertexs * sizeof(int *));

	for (i = 0; i < vertexs; i++)
		temp[i] = (int *)malloc(vertexs * sizeof(int));

	return temp;

}

// 清空visited[]
void clearVisited() {
	int i;
	for (i = 0; i < MAX; i++) {
		visited[i] = 0;
	}
}

// 打印矩阵
void printGraph() {

	int i, j;

	for (i = 0; i < vertexs; i++) {
		for (j = 0; j < vertexs; j++) {
			printf("%3d", graph[i][j]);
			if (j == vertexs - 1) {
				printf("\n");
			}
		}
	}

}

// 读取矩阵
int **init() {

	int v1, v2, w, i, j;

	read = fopen("input.txt", "r");
	if (read == NULL) {
		fprintf(stderr, "%s\n", "The file doesn't exist.");
		exit(EXIT_FAILURE);
	}

	fscanf(read, "%hd %hd", &vertexs, &edges);

	graph = generateTemplate();

	for (i = 0; i < vertexs; i++) {
		for (j = 0; j < vertexs; j++) {
			graph[i][j] = 0;
		}
	}

	while (fscanf(read, "%d %d %d", &v1, &v2, &w) != EOF)
		graph[v1][v2] = w;

	clearVisited();

}

// dfs
void dfs(int v) {

	int j;
	printf("V%d  ", v);
	visited[v] = 1;
	for (j = 0; j < vertexs; j++) {
		if (!visited[j] && graph[v][j] != 0) {
			visited[j] = 1;
			dfs(j);
		}
	}
}

// 销毁指针
void trash() {

	int i;

	fclose(read);
	
	for (i = 0; i < vertexs; i++) {
		free(graph[i]);
	}

	free(graph);
}

int main() {
	init();
	dfs(0);
	printf("\n");
	trash();
	return 0;
}
```

```
6 11
0 1 50
0 2 10
0 4 45
1 2 15
1 4 10
2 0 20
2 3 15
3 1 20
3 4 35
4 3 30
5 3 3
```

## Q3

题目要求写出关于图中最大边权重值 maxL 及结点个数 n 的函数`LARGE()`，来计算函数`shortestPath()`上下文中为无路径边设定的适合最大值 LARGE 。

由于 LARGE 需要满足以下两点：

- 大于图中任意的权重值
- 该值不会在其他路径中被生成

因为用到 LARGE 时，必有一个或一个以上结点是不连通的，`LARGE()`函数的其中一种写法表示如下：

```
int LARGE(int maxL, int n) {
    return (maxL * n);
}
```

## Q4

回答：这六个表达式无法定义一个偏序关系，证明如下：

假设六个表达式能够定义一个偏序关系，必定满足计算机科学中的偏序关系的传递性，那么可得：`4 < 0; 0 < 1; 1 < 4; 4 < 4;`，其中的`4 < 4`违反了偏序关系的另一个性质：反自反性，违背了六个表达式能够定义一个偏序关系的前提，则前提错误，则这六个表达式无法定义一个偏序关系。

## Q5

设图 6.46 图中的事件`0->1`为活动a1，`0->2`为a2，`1->3`为a3，`2->3`为a4，`2->4`为a5，`3->4`为a6，`3->5`为a7，`3->6`为a8，`4->6`为a9，`4->7`为a10，`5->9`为a11，`6->8`为a12，`7->8`为a13，`8->9`为a14。

(a)

由`forward-backward`方法可得各个活动的最短时间和最长时间：

`ee[0]:0 , ee[1]:5 , ee[2]:6 , ee[3]:12 , ee[4]:15 , ee[5]:16 , ee[6]:16 , ee[7]:19 , ee[8]:21 , ee[9]:23 `

`le[9]:23 , le[8]:21 , le[7]:19 , le[6]:16 , le[5]:19 , le[4]:15 , le[3]:12 , le[2]:6 , le[1]:9 , le[0]:0`

(b)

由(a)可得，最短时间为ee[9]，大约23天。

(c)

`critical`的条件是`e(i) = l(i)`，由上(a)可得，满足条件的活动有：a2, a4, a6, a8, a10, a12, a13, a14

(d)

整个工序有`critical-path`两条，由事件表示为：`0-2-3-6-8-9`、`0-2-3-4-7-8-9`。

当缩短所有`critical-path`中共同活动的所需时间时能够缩短整个工序的耗时，所以缩短活动a2，a4，a14中任意一个活动的时间都能够缩短整个工序的耗时。