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
