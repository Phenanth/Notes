# DS_hw3

## Q1

```
//Write functions readPoly() and printPoly() that allow the user to create and print p
#include <stdio.h>
#define MAX_TERMS 100
typedef struct {
	float coef; // 系数
	int expon; // 指数
} polynomial;
polynomial terms[MAX_TERMS];
int avail = 0;

void readPoly();
void printPoly();

int main(){
	readPoly();
	printPoly();
	return 0;
}

void readPoly(){
	int i;
	printf("%s\n", "Input the number of how many polynomials you want to input? (Input a number which is no bigger than 100.)");
	scanf("%d", &avail);
	printf("%s\n", "Input the coefficient and the exponent of the polynomial:");
	for (i = 0; i < avail; i++)
		scanf("%f %d", &terms[i].coef, &terms[i].expon);
	printf("%s\n", "Polynomial successfully inputed.");
}

void printPoly(){
	int i;
	printf("%s\n", "The polynomial is:");
	for (i = 0; i < avail; i++){
		printf("%.2f*x^%d ", terms[i].coef, terms[i].expon);
		if (i != avail-1)
			printf("%s", "+ ");
	}
	printf("\nPolyminal successfully printed\n");
}
```

## Q2

```
// Write a function, peval(), that evaluates a polynomial at some value, x0.
// Try to minimize the number of operations and give out the time complexity.
#include <stdio.h>
#include <math.h>
#define MAX_TERMS 100
typedef struct {
	float coef; // 系数
	int expon; // 指数
} polynomial;

void readPoly(polynomial terms[], int* avail);
double peval(polynomial terms[], int avail, double x0);
void printPoly(polynomial terms[], int avail);


int main(){
	polynomial terms[MAX_TERMS];
	int avail = 0;
	double x0, result;
	readPoly(terms, &avail);
	printf("%s\n", "Input the value of x0:");
	scanf("%lf", &x0);
	result = peval(terms, avail, x0);
	printf("%s%.3lf\n", "The result of the evaluation is: ", result);
	printPoly(terms, avail);
	return 0;
}

void readPoly(polynomial terms[], int* avail){
	int i;
	printf("%s\n", "Input the number of how many polynomials you want to input? (Input a number which is no bigger than 100.)");
	scanf("%d", avail);
	printf("%s\n", "Input the coefficient and the exponent of the polynomial:");
	for (i = 0; i < *avail; i++)
		scanf("%f %d", &terms[i].coef, &terms[i].expon);
	printf("%s\n", "Polynomial successfully inputed.");
}

double peval(polynomial terms[], int avail, double x0){
	int i;
	double result = 0;
	for (i = 0; i < avail; i++){
		result += terms[i].coef * pow(x0, terms[i].expon);
	}
	return result;
}

void printPoly(polynomial terms[], int avail){
	int i;
	printf("%s\n", "The polynomial is:");
	for (i = 0; i < avail; i++){
		printf("%.2f*x^%d ", terms[i].coef, terms[i].expon);
		if (i != avail-1)
			printf("%s", "+ ");
	}
	printf("\nPolyminal successfully printed\n");
}
```

## Q3

```
void fastTranspose(term a[], term b[]){
    int rowTerms[MAX_COL], startingPos[MAX_COL];
    int i,j, numCols = a[0].col, numTerms - a[0].value;
    b[0].row = numCols; b[0].col = a[0].row;
    b[0].value = numTerms;
    if (numTerms > 0) {
        for (i = 0; i < numCols; i++)
            rowTerms[i] = 0;
        for (i = 1; i <= numTerms; i++)
            rowTerms[a[i].col]++;
        startingPos[0] = 1;
        for (i = 1; i < numCols; i++)
            startingPos[i] = startingPos[i-1] + rowTerms[i-1];
        for (i = 1; i <= numTerms; i++){
            j = startingPos[a[i].col]++;
            b[j].row = a[i].col; b[j].col = a[i].row;
            b[j].value = a[i].value;
        }
    }
}
```

时间复杂度分析：
快速转置函数根据共有的行数和列数以及矩阵中一共有多少个值，每一列的起始位置的数据和每一列有多少个数字，使得转置部分只需要遍历一次行和列即可，故时间复杂度为O(column+row)。

空间复杂度分析：
要计量fastTranspose函数的空间复杂度，要从两个部分计量：固定空间和可变空间。
固定空间是for循环中的int变量i, j, numCols, numTerms。可变空间是根据矩阵大小而变化的term a, term b, rowTerms, startingPos。
总的空间复杂度为：S(p) = c + S(fastTranspose) = 4*4 + 2*4*MAX_COL + (MAX_COL)^2

对快速转置算法的短评：
快速转置算法的优点：避免使用for循环的嵌套，耗时大大低于普通转置算法。
快速转置算法的缺点：需要消耗可变空间的rowTerms和startingPos数组来存放非零项的初始位置和每列有多少项非零项，空间复杂度大于一般转置算法。