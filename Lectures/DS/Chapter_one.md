# 1.2.2 Dynamic Memory Allocation

Q1：Translate #1.2.2 and #1.2.3 (on page 5 to page 7) into Chinese.

## 1.2.2 动态内存分配

你可能会想要在你的程序中申请储存信息的空间。在你写程序的时候，你可能并不清楚你将会用到多少空间（举个例子，数组的大小将取决于程序中的输入），你也并不想申请一个可能永远都不会被用到的巨大区域。为了解决这个问题，C语言提供了一个叫做堆的机制，使其可以在运行时分配存储空间。无论你什么时候需要一片新的内存，你都可以调用malloc函数来获得你需要的大小的空间。如果内存足够分配这么大的一片区域，函数将会返回一个指向这片内存之初的指针。反之，函数将会返回一个NULL指针。当之后你不再需要这片内存区域，你可以调用free函数来将这些内存还给系统。一旦先前的那片内存被释放了，它就将会变成不能用的了。程序1.1向我们展示如何通过指针变量来分配与释放内存。（to pointer variables没翻译）
```
int i, *pi;
float f, *pf;
pi = (int *) malloc(sizeof(int));
pf = (float *)malloc(sizeof(float));
*pi = 1024;
*pf = 3.14;
printf("an integer = %d, a float = %f\n", *pi, *pf);
free(pi);
free(pf);
```
> 程序1.1：分配与释放内存空间

调用malloc函数包括一个指定存放int或float数据的这片内存有多大的参数。函数返回的结果是一个指针，它指向被分配的适当大小的内存的第一个字节。返回的这个指针的类型视情况而定。在一些系统中返回的指针是char * 类型，指的是一个指向char的指针。而有时在使用ANSI C的时候，返回的结果会是一个void *。符号(int *)和(float *)都是强制类型转换的意思，在程序1.1中都被省略掉了。这些符号将函数返回的指针转换为正确的类型。然后这些指针才被分配为适宜的指针变量。而free函数则能够释放方才通过malloc函数分配的内存空间。在一些版本的C中，free的实参需要是一个char *，而ANSI C中的实参需要是一个void *。不过，实际上这些实参的强制转换都在free的调用中被省略掉了。
既然调用mallo可能因为所需储存空间不足的问题而失败，我们可以改写几行代码，使其变得更为适用，来替换程序1.1的代码中调用malloc函数的部分。
```
if ((pi = (int *)malloc(sizeof(int))) === NULL || (pf = (float *)malloc(sizeof(float))) === NULL ){
    fprintf(stderr, "Insufficient memory");
    exit(EXIT_FAILURE);
}

```
或者等价于：
```
if (!(pi = malloc(sizeof(int))) || !(pf = malloc(sizeof(float)))){
    fprintf(stderr, "Insufficient memory");
    exit(EXIT_FAILURE);
}
```

因为malloc函数可能会在你的程序中多次使用，将调用malloc函数和它的后续错误处理都用宏定义的形式进行预处理也是一个颇为便捷的选择。以下是一种可行的宏定义方式：
```
#define MALLOC(p,s) \
    if (!((p) = malloc(s))) { \
        fprintf(stderr, "Insufficient memory"); \
        exit(EXIT_FAILURE; \
    }
```
现在，原本在程序1.1中调用malloc函数的两行可以被替换为：
```
MALLOC(pi, sizeof(int));
MALLOC(PF, sizeof(float));
```
而在程序1.1中如果我们在printf语句后插入这一行：`pf = (float *) malloc(sizeof(float));`，那么原本指向存储3.14这个值的指针将会消失。现在就没有别的方法来取回这个储存单元的信息了。这是悬挂参考的一个例子。无论何时，如果指向动态分配的内存区域的指针都丢失了，对于软件而言，这片区域就变得不可探寻了。鉴于软件是被视为使用指针和动态内存空间的，那么一旦不再需要这片空间，我们应该马上将它还给系统。


## 1.2.3 指针也危险

当使用C语言编程的时候，将未指向任何对象的指针都设置为NULL类型是一种明智的做法。这会让你的程序免于以下两种风险：1. 访问属于你的程序内存以外的空间 2. 访问一个实际上并不包含被引用的合法对象的空间。在部分电脑上，你可以对一个空指针解引用，它的结果将会是NULL，这使得程序能够继续执行。而在另外一些电脑上，只要是想要对处在零位置上的位进行返回操作，最后总会造成严重的错误。

你也可以使用显式类型转换来将指针转换为另外一种类型，这也是一种明智的战术。举个例子：
```
pi = malloc(sizeof(int));
 /* 将一个int *类型的指针分配至pi*/
pf = (float *) pi;
 /* 将int类型的指针转换为float类型*/
```

另外值得注意的是，在很多系统中，指针的大小和int类型是相同的。因为int是一个默认的说明符，一些开发者在定义一个函数的时候往往会省略返回类型。而这些函数的默认返回类型int在之后又可能会被解读为是一个指针。在一些电脑上，这样的尝试被证明为是危险的，因此开发者应当明确指定函数的返回类型。

## Q2
```
#include <stdio.h>
int main(){
	int x, y, z;
	printf("Please input three integers:\n");
	scanf("%d %d %d", &x, &y, &z);
	int max = x, min = x, middle = x;
	(y > max)?(max = y):((y < min)?(min = y):(middle = y));
	(z > max)?(max = z):((z < min)?(min = z):(middle = z));
	(y < max && y > min)?(middle = y):(middle = middle);
	printf("The ascending order of those three numbers is: %d %d %d\n", min, middle, max );
	return 0;
}
```

## Q3
```
#include <stdio.h>
// Given(给定) n, a positive integer(正整数), detemine if n is the sum its divisors(除数), that is,
// if n is the sum of all t such that 1<=t<n and t divides n.
int main(){
	int num;
	scanf("%d", &num);
	int sum = 0, div;
	for(div = 1; div <= num/2+1; div++){
		if(num % div == 0 && div < num){
			sum += div;
		}
	}
	if(sum == num){
		printf("Yes\n");
	}else printf("No\n");
	return 0;
}
```

## Q4

```
#include <stdio.h>
// The factorial function n! has value 1 when n<=1 and value n*(n-1)! when n>1. 
// Write both a recursive(递归) and an iterative(迭代，即非递归) C function to compute n!.

int iterativeFactorialCal(int n); // 非递归
int recursiveFactorialCal(int n); // 递归

int main(){

	int n, result_ite, result_rec;
	scanf("%d", &n);

	result_ite = iterativeFactorialCal(n);
	result_rec = recursiveFactorialCal(n);

	printf("Iterative: %d, Recursive: %d\n", result_ite, result_rec);

	return 0;
}

int iterativeFactorialCal(int n){
	int result = 1;
	for(int i = 1; i <= n; i++){
		result *= i;
	}
	return result;
}

int recursiveFactorialCal(int n){
	if(n <= 1){
		return 1;
	}else return n * recursiveFactorialCal(n - 1);
}

```

## Q5

```
#include <stdio.h>
// The Fibonacci numbers are defined as: f(0)=0, f(1)=1, and f(i)=f(i-1)+f(i-2) for i>1. 
// Write both a recursive and an iterative C function to compute f(i).
int iterativeFibonacciCal(int n); // 非递归
int recursiveFibonacciCal(int n); // 递归
int main(){
    int n, result_ite, result_rec;
    scanf("%d", &n);
    result_ite = iterativeFibonacciCal(n);
    result_rec = recursiveFibonacciCal(n);
    printf("Iterative: %d, Recursive: %d\n", result_ite, result_rec);
    return 0;
}
int iterativeFibonacciCal(int n){
    int result_m = 0, result = 1;
    for(int i = 1; i < n; i++){
        int temp = result_m;
        result_m = result;
        result += temp;
    }
    if(n == 0)
        return 0;
    return result;
}
int recursiveFibonacciCal(int n){
    if(n == 0)
        return 0;
    else if(n == 1)
        return 1;
    else return recursiveFibonacciCal(n - 1) + recursiveFibonacciCal(n - 2);
}
```
