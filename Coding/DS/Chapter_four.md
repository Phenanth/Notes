# DS_hw4

## Q1

当n=3时。

将车的序号排列为0, 1, 2，其中不可能实现的排列方式为：2, 0, 1。

其余的排列方式：0, 1, 2、0, 2, 1、1, 0, 2、1, 2, 0、2, 1, 0都是可能的。

当n=4时。

将车的序号排列为0, 1, 2, 3，其中不可能的排列方式为：0, 3, 1, 2、1, 3, 0, 2、2, 0, 1, 3、2, 0, 3, 1、2, 3, 0, 1、3, 2, 0, 1、3, 1, 2, 0、3, 1, 0, 2、3, 0, 2, 1、3, 0, 1, 2。

其余排列方式为可能。


## Q2

deque的储存方式为数组，通过规定deque的最大储存空间MAX以及定义两个整型变量pf、pe来找到队伍的两端。

`main()`函数中为通过`printArray()`观察`Add()`和 `Delete()`对一维数组存储的deque进行的数据操作。

源代码如下：

```
#include <stdio.h>
#define MAX 50


void Add(int deq[], int* p, int data, int front);
int Delete(int deq[], int* p, int front);

void printArray(int arr[]);

int main() {
	int deq[MAX] = { 0 }, pf = 0, pe = 0;
	printArray(deq);
	Add(deq, &pf, 4, 1);
	printArray(deq);
	Add(deq, &pe, 5, 0);
	printArray(deq);
	Delete(deq, &pf, 1);
	printArray(deq);
	Delete(deq, &pe, 0);
	printArray(deq);
	return 0;
}

void Add(int deq[], int* p, int data, int front) {
    // *p为队伍左端或右端的位置，front表示是队伍的左端
	int pos;
	if (*p >= MAX / 2 + 1) {
	    printf("%s\n", "Memory Exceeded.");
    } else {
    	if (front) {
    		pos = MAX / 2 - 1 - *p;
    		deq[pos] = data;
    	} else {
    		pos = MAX / 2 + *p;
    		deq[pos] = data;
    	}
    	(*p)++;
    }
}


int Delete(int deq[], int* p, int front) {
    // *p为队伍左端或右端的位置，front表示是队伍的左端
	int pos, temp = 0;
    if (*p <= 0) {
	    printf("%s\n", "Memory Exceeded.");
    } else {
    	if (front) {
        	pos = MAX / 2 - 1 - *p + 1;
        	temp = deq[pos];
        	deq[pos] = 0;
    	} else {
    		pos = MAX / 2 + *p - 1;
    		temp = deq[pos];
    		deq[pos] = 0;
    	}
    	(*p)--;
    }
    return temp;
}

void printArray(int arr[]) {
	int i, isZero = 0;
	printf("%s\n", "Array is:");
	for (i = 0; i < MAX; i++) {
		if (arr[i] != 0) {
			printf("%d ", arr[i]);
			isZero++;
		}
	}	
	if (!isZero) {
		printf("%s", "Array is Zero!");
	}
	printf("\n");
}
```
运行结果如下：

```
CharlottedeMac:demo SKHR$ ./a.out
Array is:
Array is Zero!
Array is:
4 
Array is:
4 5 
Array is:
5 
Array is:
Array is Zero!
```

## Q3

(a)
`ab*c*`

(b)
`a-1*b+c-d+`

(c)
`a-1*b*c+`

(d)
`ab+d*ead*f+/c+`

(e)
`ab&&c||ef>!||`

(f)
`abc<cd>||!&&!ce<||`

## Q4

说明：
`Push()`函数中通过传入表示栈0的栈顶的整型变量pf和表示栈1的栈顶的整型变量pe，计算其总和与栈大小MEMORY_SIZE的大小关系来判断双端栈是否为满。

`main()`函数中为通过`printArray()`观察`Push()`和 `Pop()`对一维数组存储的deque进行的数据操作。


```
#include <stdio.h>
#include <stdlib.h>
#define MEMORY_SIZE 10

void Push(int memory[], int i, int data, int *pf, int *pe);
int Pop(int memory[], int i, int *pos);
void printArray(int arr[]);

int main() {
	int memory[MEMORY_SIZE] = { 0 }, pf = 0, pe = 0;
	/*
	printArray(memory);
	Push(memory, 0, 1, &pf, &pe);
	printArray(memory);
	Push(memory, 1, 2, &pf, &pe);
	printArray(memory);
	Push(memory, 1, 5, &pf, &pe);
	printArray(memory);
	Pop(memory, 0, &pf);
	printArray(memory);
	Pop(memory, 1, &pe);
	printArray(memory);
	*/
	int i;
	for (i = 1; i < 7; i++) {
		Push(memory, 0, i, &pf, &pe);
		Push(memory, 1, i, &pf, &pe);
		printArray(memory);
	}
	for(i = 0; i < 5; i++) {
		Pop(memory, 0, &pf);
		Pop(memory, 1, &pe);
		printArray(memory);
	}
	return 0;

}


void Push(int memory[], int i, int data, int *pf, int *pe) {
    // pf为左栈栈顶 pe为右栈栈顶 i用于分辨是左栈还是右栈
    // 判断total总栈空间与MEMORY_SIZE关系来辨别总栈是否为满
	int posp, total = *pf + *pe;
	if (total >= MEMORY_SIZE) {
		printf("%s\n", "Memory Size Not Enough!");
	} else {
		if (!i) {
			posp = *pf;
			memory[posp] = data;
			(*pf)++;
		} else {
			posp = MEMORY_SIZE - 1 - *pe;
			memory[posp] = data;
			(*pe)++;
		}
	}
}


int Pop(int memory[], int i, int *pos) {
    // pos为要操作的栈顶位置，i用于分辨是左栈还是右栈
	int data = 0, posp;
	if (!i) {
		posp = *pos - 1;
	} else {
		posp = MEMORY_SIZE - *pos;
	}
	if (posp >= 0 && posp < MEMORY_SIZE) {
		data = memory[posp];
		memory[posp] = 0;
		(*pos)--;
	}
	return data;
}

void printArray(int arr[]) {
	int i, isZero = 0;
	printf("%s\n", "Array is:");
	for (i = 0; i < MEMORY_SIZE; i++) {
		printf("%d ", arr[i]);
		if (arr[i] != 0) {
			isZero++;
		}
	}	
	printf("\n");
	if (!isZero) {
		printf("%s\n", "Array is Zero!");
	}
}
```

```
CharlottedeMac:demo SKHR$ ./a.out
Array is:
1 0 0 0 0 0 0 0 0 1 
Array is:
1 2 0 0 0 0 0 0 2 1 
Array is:
1 2 3 0 0 0 0 3 2 1 
Array is:
1 2 3 4 0 0 4 3 2 1 
Array is:
1 2 3 4 5 5 4 3 2 1 
Memory Size Not Enough!
Memory Size Not Enough!
Array is:
1 2 3 4 5 5 4 3 2 1 
Array is:
1 2 3 4 0 0 4 3 2 1 
Array is:
1 2 3 0 0 0 0 3 2 1 
Array is:
1 2 0 0 0 0 0 0 2 1 
Array is:
1 0 0 0 0 0 0 0 0 1 
Array is:
0 0 0 0 0 0 0 0 0 0 
Array is Zero!

```