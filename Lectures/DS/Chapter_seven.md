# DS_hw7

# 待文档化：

## Q1

(a)

`inorder`: EDCBA

`preorder`: ABCDE

`postorder`: EDCBA

`levelorder`: ABCDE

(b)

`inorder`: HDIBEAFCG

`preorder`: ABDHIECFG

`postorder`: HIDEBFGCA

`levelorder`: ABCDEFGHI


## Q2

`inorder`: ECBDA

`preorder`: ABCED

`postorder`: ECDBA

`levelorder`: ABCDE

## Q3

改了关于判断条件的语句，但是入栈出栈的函数调用的次数原理上来说还是没有改变。

```
void iterInorder2(treePointer tree) {
    int top = -1;
    treePointer stack[MAX], node = tree->left;
    while (node != NULL && !isEmpty(stack)) {
        while (node != NULL) {
            Push(stack, node);
            node = node->left;
        }
        node = Pop(stack);
        printf("%d", node->data);
        node = node->right;
    }
}
```

## Q4

```
#include <stdio.h>
#include <stdlib.h>
#define MAX 50

typedef struct nodeTree{
	char data;
	struct nodeTree *left;
	struct nodeTree *right;
}nodeTree;
typedef nodeTree *nodePointer;

nodePointer CreateTree() {
	nodePointer temp;
	char ch;
	scanf("%c", &ch);
	if (ch == '#') temp = NULL;
	else {
		temp = (nodePointer)malloc(sizeof(nodeTree));
		temp->data = ch;
		temp->left = CreateTree();
		temp->right = CreateTree();
	}
	return temp;
}

void inorder(nodePointer tree) {
	if (tree) {
		inorder(tree->left);
		printf("%c", tree->data);
		inorder(tree->right);
	}
}

void preorder(nodePointer tree) {
	if (tree) {
		printf("%c", tree->data);
		preorder(tree->left);
		preorder(tree->right);
	}
}

void swapTree(nodePointer tree) {
	nodePointer swp = NULL;
	swp = tree->left;
	tree->left = tree->right;
	tree->right = swp;
	if (tree->left)
		swapTree(tree->left);
	if (tree->right)
		swapTree(tree->right);
}

//  ABD#G##E##CF#H###

int main() {

	nodePointer tree = CreateTree(), temp = NULL;
	printf("%s\n", "Inorder:");
	inorder(tree);
	printf("\n");

	printf("%s\n", "Preorder:");
	preorder(tree);
	printf("\n");

	swapTree(tree);	

	printf("%s\n", "Swaped inorder:");
	inorder(tree);
	printf("\n");

	printf("%s\n", "Preorder:");
	preorder(tree);
	printf("\n");
	return 0;
}
```

## Q5

图用ps画好存在win的p7文件夹下了

# 未完成：

## Q6

需要写将一系列数字创造成一个大堆和小堆的函数。
可以用之前写的遍历函数来检测。

```

#include <stdio.h>
#include <stdlib.h>
#define MAX 50

typedef struct heap {
	int data;
	/*
	other field.
	*/
}Heap;
typedef struct heap *heapPointer;


void PushMaxHeap(Heap heap[], int *n, Heap item) {
	int i;
	if (*n >= MAX) {
		fprintf(stderr, "Heap is full. \n");
		exit(EXIT_FAILURE);
	}
	i = ++(*n);
	while ((i != 1) && (item.data > heap[i / 2].data)) {
		heap[i].data = heap[i/2].data;
		i /= 2;
	}
	heap[i].data = item.data;
}

void PushMinHeap(Heap heap[], int *n, Heap item) {
	int i;
	if (*n >= MAX) {
		fprintf(stderr, "Heap is full. \n");
		exit(EXIT_FAILURE);
	}
	i = ++(*n);
	while ((i != 1) && (item.data < heap[i/2].data)) {
		heap[i].data = heap[i/2].data;
		i /= 2;
	}
	heap[i].data = item.data;
}

Heap *CreateMaxHeap() {
	int temp = 0, n = 0;
	Heap *heap;
	heap = (Heap *)malloc(sizeof(Heap) * MAX);
	scanf("%d", &temp);
	while (temp != -1) {
		Heap tmp;
		tmp.data = temp;
		PushMaxHeap(heap, &n, tmp);
		scanf("%d", &temp);
	}
	return heap;
}

Heap *CreateMinHeap() {
	int temp = 0, n = 0;
	Heap *heap;
	heap = (Heap *)malloc(sizeof(Heap) * MAX);
	scanf("%d", &temp);
	while (temp != -1) {
		Heap tmp;
		tmp.data = temp;
		PushMinHeap(heap, &n, tmp);
		scanf("%d", &temp);
	}
	return heap;
}	

// 7 16 49 82 5 31 6 2 44 -1

int main() {

	int i = 1;
	Heap *minHeap, *maxHeap;
	minHeap = CreateMinHeap();
	maxHeap = CreateMaxHeap();
	minHeap++, maxHeap++;
	while (i < 10) {
		printf("%d ", (*minHeap).data);
		minHeap++, i++;
	}
	printf("\n");

	i = 1;
	while (i < 10) {
		printf("%d ", (*maxHeap).data);
		maxHeap++, i++;
	}
	printf("\n");

	return 0;
}
```

## Q7

通过使用叶结点到树顶数字的二分查找的方法使复杂度变为O(loglogn)，实现这个算法。还要说这个算法比起普通的算法的优点。

```
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define MAX 50

typedef struct heap {
	int data;
	/*
	other field.
	*/
}Heap;
typedef struct heap *heapPointer;


void PushMaxHeap(Heap heap[], int *n, Heap item) {
	int i, j, top = 0, bottom = 0, mid, pos;
	if (*n >= MAX) {
		fprintf(stderr, "Heap is full. \n");
		exit(EXIT_FAILURE);
	}
	i = ++(*n);
	for (j = 1; j < i; j *= 2) {
		bottom++;
	}
	while (top < bottom) {
		mid = (top + bottom) / 2;
		pos = pow(2, mid);
		if (heap[pos].data < item.data) {
			bottom = mid;
		}
		else if (heap[pos].data > item.data) {
			top = mid;
			if (bottom - top == 1) {
				break;
			}
		}
		else {
			break;
		}
	}
	while ((i != 1) && (item.data > heap[i / 2].data)) {
		heap[i].data = heap[i / 2].data;
		i /= 2;
	}
	heap[i].data = item.data;
}

void PushMinHeap(Heap heap[], int *n, Heap item) {
	int i, j, top = 0, bottom = 0, mid, pos;
	if (*n >= MAX) {
		fprintf(stderr, "Heap is full. \n");
		exit(EXIT_FAILURE);
	}
	i = ++(*n);
	for (j = 1; j < i; j *= 2) {
		bottom++;
	}
	while (top < bottom) {
		mid = (top + bottom) / 2;
		pos = pow(2, mid);
		if (heap[pos].data < item.data) {
			bottom = mid;
		}
		else if (heap[pos].data > item.data) {
			top = mid;
			if (bottom - top == 1) {
				break;
			}
		}
		else {
			break;
		}
	}
	while ((i != 1) && (item.data < heap[i / 2].data)) {
		heap[i].data = heap[i / 2].data;
		i /= 2;
	}
	heap[i].data = item.data;
}

Heap *CreateMaxHeap() {
	int temp = 0, n = 0;
	Heap *heap;
	heap = (Heap *)malloc(sizeof(Heap) * MAX);
	scanf("%d", &temp);
	while (temp != -1) {
		Heap tmp;
 		tmp.data = temp;
		PushMaxHeap(heap, &n, tmp);
		scanf("%d", &temp);
	}
	return heap;
}

Heap *CreateMinHeap() {
	int temp = 0, n = 0;
	Heap *heap;
	heap = (Heap *)malloc(sizeof(Heap) * MAX);
	scanf("%d", &temp);
	while (temp != -1) {
		Heap tmp;
		tmp.data = temp;
		PushMinHeap(heap, &n, tmp);
		scanf("%d", &temp);
	}
	return heap;
}

// 7 16 49 82 5 31 6 2 44 -1

int main() {

	int i = 1;
	Heap  *maxHeap, *minHeap;
	minHeap = CreateMinHeap();
	maxHeap = CreateMaxHeap();
	minHeap++;
	maxHeap++;
	
	while (i < 10) {
	printf("%d ", (*minHeap).data);
	minHeap++, i++;
	}
	printf("\n");
	
	i = 1;
	while (i < 10) {
		printf("%d ", (*maxHeap).data);
		maxHeap++, i++;
	}
	printf("\n");

	return 0;
}
```