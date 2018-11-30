/*
# 最大公约数问题

## 题目描述
题目：最大公约数问题：
描述：给定两个正整数，求他们的最大公约数。
输入：输入一行，包含两个正整数m, n（m, n<1,000,000,000)。
输出：输出一个正整数，即这两个正整数的最大公约数。

## 算法

算法1（欧几里得算法）：
1. 如果n = 0，返回m的值作为结果，同时过程结束；否则，进入第二步。
2. m除以n，将余数赋给r。
3. 将n的值赋给m，将r的值赋给n，返回第一步。

算法2（连续整数检测算法）：
1. 将min{m, n}的值赋给t。
2. m除以t，如果余数为零，进入第三步，否则进入第四步。
3. n除以t， 如果余数为零，返回t的值作为结果；否则进入第四步。
4. 把t的值减1，返回第二步。

算法3（算术方法计算算法）：
1. 找到m的所有质因数。
2. 找到n的所有质因数。
3. 从第一步和第二步求到的质因数分解式中找出所有的公因数。
（如果p是一个公因数，而且在m和n的质因数分解式分别出现过pm和pn次，
那么应该将p重复min{pm, pn}次。
4. 将第三步中找到的质因数相乘，其结果作为给定数字的最大公因数。

## 时间复杂度分析

Euclid algorithm:
由于欧几里得算法最终的余数为零，那么逆着看途中产生的结果数可以说是一个数列，
形似：{0, t, kt, nkt + t, mnkt + mt + t}，每相邻两项之和都小于较大一项的后一项。
这个增长速度是比斐波那契数列的增长速度（时间复杂度O(2^k)）要快的。
反过来看，设欧几里得算法需要k次计算，那么t = O(2^k)， k = O(log(t))。
则它的时间复杂度是O(log(t))，对数性增长。

Increasing algorithm:
由于连续整数检测算法使用的t值最好情况是一次就得到结果，最差情况是n（被求数字）次才能得到结果，
则它的平均的时间复杂度是O(n)，是线性的。

Arithmetic algorithm:
由于算法中需要对两数进行质因数分解，有两个嵌套的`for`循环，这影响了这个算法的总耗时，
则它的时间复杂度是O(n^2)，呈平方增长。

## 输入与输出

输入1：
```
60 24
```
输出1：
```
The result of the Euclid algorithm is: 12
The result of the Increasing algorithm is: 12
The result of the Arithmetic algorithm is: 12
```

输入2：
```
100 0
```
输出2：
```
The input must be two number no smaller than 1 and no bigger than 1,000,000,000.

```

输入3：
```
100 1
```
输出3：
```
The result of the Euclid algorithm is: 1
The result of the Increasing algorithm is: 1
The result of the Arithmetic algorithm is: 1
```

输入4：
```
50 33
```
输出4：
```
The result of the Euclid algorithm is: 1
The result of the Increasing algorithm is: 1
The result of the Arithmetic algorithm is: 1
```

输入5：
```
55 100
```
输出5：
```
The result of the Euclid algorithm is: 5
The result of the Increasing algorithm is: 5
The result of the Arithmetic algorithm is: 5
```

## 源代码
```
*/
// FILE `main.c`:
#include "myHead.h"

int main() {

	int m = 0, n = 0, rst1 = 0, rst2 = 0, rst3 = 0;

	do {
		scanf("%d %d", &m, &n);
		if (m == 0 || n == 0) {
			printf("%s\n", "The input must be two number no smaller than 1 and no bigger than 1,000,000,000.");
		}
	} while (m < 1 || n < 1);

	rst1 = Euclid(m, n);
	rst2 = Increasing(m, n);
	rst3 = Arithmetic(m ,n);

	printf("%s%d\n", "The result of the Euclid algorithm is: ", rst1);
	printf("%s%d\n", "The result of the Increasing algorithm is: ", rst2);
	printf("%s%d\n", "The result of the Arithmetic algorithm is: ", rst3);

	return 0;

}

// ````````````````````````````````````````````
/*
// FILE `myHead.h`
#include <stdio.h>
#define MAX 100

// In FILE source1.c:
int Euclid(int m, int n);

// In FILE source2.c:
int Increasing(int m, int n);

// In FILE source3.c:
int Arithmetic(int m, int n);
void primeFactor(int arr[], int x);
int isPrime(int x);
void printArray(int arr[]);

#include "source1.c"
#include "source2.c"
#include "source3.c"

// `````````````````````````````````````

// FILE `source1.c`
// Euclid Algorithm
int Euclid(int m, int n) {

	int r = 0;

	// #1
	if (n == 0) {
		return m;
	}

	while (n != 0) {

		// #1
		if (m % n == 0) {
			break;
		}

		// #2&#3
		r = m % n;
		m = n;
		n = r;

	}

	return n;

}

// `````````````````````````````````````````

// FILE `source2.c`:
// Continuous Increasing Interger Algorithm
int Increasing (int m, int n) {

	int t = 0, result = 0;

	if (m == 1 || n == 1) {
		return 1;
	}

	// #1
	t = m > n ? n : m;

	while (t >= 2) {

		// #2&#4
		if (m % t != 0) {
			t -= 1;
			continue;
		}

		// #3&#4
		if (n % t == 0) {
			result = t;
			break;

		} else {
			t -= 1;
		}

	}

	// The two numbers are relatively prime numbers.
	if (t < 2) {
		result = t;
	}

	return result;
	
}

// ````````````````````````````````````````````

// FILE `source3.c`:
// Arithmetic Algorithm
int Arithmetic(int m, int n) {

	int arr1[MAX] = {0}, arr2[MAX] = {0}, result = 1, i = 0;

	// #1&#2
	primeFactor(arr1, m);
	primeFactor(arr2, n);

	// #3 & #4: Multiply the same factors.
	for (i = 0; i < MAX; i++) {

		if (arr1[i] > 0 && arr2[i] > 0) {
			result *= i;
			arr1[i] -= 1;
			arr2[i] -= 1;
			i -= 1;
		}

	}

	return result;
	
}

// Store the prime factors of a number in the array.
void primeFactor(int arr[], int x) {

	int i = 0;

	if (x == 1) {
		arr[1] += 1;
		return;
	}

	while (!isPrime(x)) {

		for (i = 2; i < (x / 2); i++) {

			if (isPrime(i) && x % i == 0) {

				arr[i] += 1;
				x /= i;
				break;

			}
		}

	}

	arr[x] += 1;

}

// Judge if it is a prime number.
int isPrime(int x) {

	int i;

	for (i = 2; i <= x; i++) {

		if (x % i == 0) {
			break;
		}

	}

	if (x == i) {
		return 1;
	} else {
		return 0;
	}

}

// Print the array, for debugging.
void printArray(int arr[]) {

	int i;

	for (i = 0; i < MAX; i++) {
		printf("%d ", arr[i]);
	}

	printf("\n");

}


```

## 结果截图

*/

