/*
# 平衡查找树的创建

## 题目描述
题目：创建一个平衡查找树
描述：根据某顺序输入平衡查找树的节点，
输入途中通过左旋、右旋、左右旋、右左旋调整结点位置。结点输入结束后生成一个平衡查找树。
输入：平衡查找树的结点值。
输出：平衡查找树的前序遍历结果。

## 算法

变治法：
1. 判断新结点值，值小于根节点插入左子树，反之插入右子树。进入第二步。
2. 统计查找树节点值，若有节点值为±2，进入第三步。无则进入第一步。
3. 找到离新插入节点最近的值为±2的节点并根据情况进行旋转操作。值绝对值小于2则进入第一步。

## 时间复杂度

变治法：
创建一棵树需要对n个节点做对数级的操作，于是时间复杂度为O(nlogn)。
对这棵数的查找与使用折半查找法对有序数组进行查找的效率相同，为O(logn)。

## 输入输出

```
5 6 8 3 2 4 7 -1
```

```
Preorder travelsal of the tree:
5 3 2 4 7 6 8 
Inorder travels of the tree:
2 3 4 5 6 7 8
```

## 源代码
*/
// FILE main.c:
#include "myHead.h"

int main() {

	TREEPOINTER tree = NULL;

	tree = CreateTree();

	printf("%s\n", "Preorder travelsal of the tree:");
	PreOrderOfTree(tree);
	printf("\n");

	printf("%s\n", "Inorder travels of the tree:");
	InOrderOfTree(tree);
	printf("\n");

	return 0;

}

// ````````````````````````````````````````
/*
// FILE myHead.h:
#include <stdio.h>
#include <stdlib.h>

typedef struct tree {
	int val;
	int depth;
	struct tree *leftChild;
	struct tree *rightChild;
	struct tree *parent;
}TREE;
typedef struct tree *TREEPOINTER;


TREEPOINTER CreateTree();

TREEPOINTER Insertion(TREEPOINTER tree, TREEPOINTER node);
TREEPOINTER Insert(TREEPOINTER *tree, TREEPOINTER node, TREEPOINTER parent);
void UpdateDepth(TREEPOINTER tree);
int IsBalance(TREEPOINTER tree);
TREEPOINTER FindAltRoot(TREEPOINTER tree, TREEPOINTER node);

TREEPOINTER L_Rotate(TREEPOINTER tree);
TREEPOINTER R_Rotate(TREEPOINTER tree);
TREEPOINTER LR_Rotate(TREEPOINTER tree);
TREEPOINTER RL_Rotate(TREEPOINTER tree);

void PreOrderOfTree(TREEPOINTER tree);
void InOrderOfTree(TREEPOINTER tree);

#include "source.c"

// ````````````````````````````````````````
// FILE source.c:
// Create a AVL tree.
TREEPOINTER CreateTree() {

	int num;
	TREEPOINTER tree = NULL;

	scanf("%d", &num);
	while (num != -1) {
		int mode = 0;
		TREEPOINTER alt = NULL, temp = NULL;

		// Initilization of the new node.
		temp = (TREEPOINTER)malloc(sizeof(TREE));
		temp->val = num;
		temp->depth = 0;
		temp->leftChild = NULL;
		temp->rightChild = NULL;
		temp->parent = NULL;

		// Do insertion.
		tree = Insertion(tree, temp);

		scanf("%d", &num);

	}

	return tree;

}

// Insert and alter the tree to a AVL balanced tree.
TREEPOINTER Insertion(TREEPOINTER tree, TREEPOINTER node) {

	int flagL = 0, flagR = 0;
	TREEPOINTER temp;

	temp = Insert(&tree, node, NULL);

	if (temp) {
		// Update the depth of the inserted node.
		UpdateDepth(temp);
		// Find the root node that needs alter.
		tree = FindAltRoot(tree, temp);
	}
	else {
		free(temp);
	}

	return tree;

}

// The insert of a node.
TREEPOINTER Insert(TREEPOINTER *tree, TREEPOINTER node, TREEPOINTER parent) {

	TREEPOINTER temp = NULL;

	if (*tree == NULL) {
		*tree = node;
		node->parent = parent;
		temp = *tree;
	} else {
		if (node->val < (*tree)->val) {
			temp = Insert(&((*tree)->leftChild), node, *tree);
		}
		else if (node->val > (*tree)->val) {
			temp = Insert(&((*tree)->rightChild), node, *tree);
		}
		else {
			temp = NULL;
		}
	}

	return temp;
}

// Update the depth of a node.
void UpdateDepth(TREEPOINTER tree) {

	if (!tree) {
		return;
	} else {
		int depthL = 0;
		int depthR = 0;
		if (tree->leftChild) {
			depthL = tree->leftChild->depth;
		}
		if (tree->rightChild) {
			depthR = tree->rightChild->depth;
		}
		tree->depth = depthL > depthR ? (depthL + 1) : (depthR + 1);
	}

}

// Return the balance condition.
int IsBalance(TREEPOINTER tree) {

	if (!tree) {
		return 0;
	}
	else {
		int depthL = 0;
		int depthR = 0;
		if (tree->leftChild) {
			depthL = tree->leftChild->depth;
		}
		if (tree->rightChild) {
			depthR = tree->rightChild->depth;
		}
		return depthL - depthR;
	}

}

// Find the node which needs alter operation.
TREEPOINTER FindAltRoot(TREEPOINTER tree, TREEPOINTER node) {
	
	int balance = 0;

	while (node != NULL) {
		UpdateDepth(node);
		balance = IsBalance(node);

		// Alter the tree by the balance condition.
		if (balance > 1 || balance < -1) {
			if (balance > 1) {
				if (IsBalance(node->leftChild) > 0) {
					node = L_Rotate(node);
				} else {
					node = LR_Rotate(node);
				}
			} else {
				if (IsBalance(node->rightChild) < 0) {
					node = R_Rotate(node);
				} else {
					node = RL_Rotate(node);
				}
			}
			if (node->parent == NULL) {
				tree = node;
				break;
			}
		}
		node = node->parent;
	}

	return tree;

}

// Left rotate.
TREEPOINTER L_Rotate(TREEPOINTER tree) {

	TREEPOINTER parent = NULL, child;

	parent = tree->parent;
	child = tree->leftChild;

	if (child->rightChild != NULL) {
		child->rightChild->parent = tree;
	}
	tree->leftChild = child->rightChild;

	UpdateDepth(tree);
	child->rightChild = tree;
	child->parent = parent;

	if (parent) {
		if (parent->leftChild == tree) {
			parent->leftChild = child;
		} else {
			parent->rightChild = child;
		}
	}

	tree->parent = child;
	UpdateDepth(child);

	return child;

}

// Right rotate.
TREEPOINTER R_Rotate(TREEPOINTER tree) {

	TREEPOINTER parent = NULL, child;

	parent = tree->parent;
	child = tree->rightChild;

	if (child->leftChild != NULL) {
		child->leftChild->parent = tree;
	}
	tree->rightChild = child->leftChild;

	UpdateDepth(tree);
	child->leftChild = tree;
	child->parent = parent;

	if (parent) {
		if (parent->leftChild == tree) {
			parent->leftChild = child;
		} else{
			parent->rightChild = child;
		}
	}

	tree->parent = child;
	UpdateDepth(child);

	return child;

}

// Left-Right rotate.
TREEPOINTER LR_Rotate(TREEPOINTER tree) {

	tree->leftChild = R_Rotate(tree->leftChild);
	return L_Rotate(tree);
}

// Right-left rotate.
TREEPOINTER RL_Rotate(TREEPOINTER tree) {

	tree->rightChild = L_Rotate(tree->rightChild);
	return R_Rotate(tree);
}

// The preorder travelsal of a tree.
void PreOrderOfTree(TREEPOINTER tree) {

	if (tree) {
		printf("%d ", tree->val);
		PreOrderOfTree(tree->leftChild);
		PreOrderOfTree(tree->rightChild);
	}

}

// The inorder travelsal of a tree.
void InOrderOfTree(TREEPOINTER tree) {

	if (tree) {
		InOrderOfTree(tree->leftChild);
		printf("%d ", tree->val);
		InOrderOfTree(tree->rightChild);
	}

}

## 结果截图

*/