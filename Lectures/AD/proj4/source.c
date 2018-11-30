// Another Decrease and Conquer algorithm.
void fnDecrease_2(int n, int tot) {

	int i;
	//  When all four numbers has a new order, print it.
	if (n == tot) {
		for (i = 0; i < tot; i++) {
			if ((i+1) % (tot) == 0) {
				printf("%d\n", a[i]);
			} else {
				printf("%d", a[i]);
			}
		}
	}
	// Backtracking when all four numbers are visited, or call the function itself.
	for (i = 0; i < tot; i++) {
		if (visit[i] == 0) {
			visit[i] = 1;
			a[n] = i + 1;
			fnDecrease_2(n + 1, tot);
			visit[i] = 0;
		}
	}

}

// Calculate the factorial result.
int Factorial(int n) {

	int i, result;

	for (i = 1, result =1; i <= n; i++) {
		result *= i;
	}

	return result;

}

// Initilization of the array using in decrease algorithm.
void init(int n) {

	int i;

	a = (int *)malloc(sizeof(int) * n);
	visit = (int *)malloc(sizeof(int) * n);

	for (i = 0; i < n; i++) {
		a[i] = i + 1;
		visit[i] = 0;
	}

}

// Apply memory space for the array.
int **initArray(int n) {

	int i, t = Factorial(n), **arr;

	arr = (int **)malloc(sizeof(int *) * t);
	for (i = 0; i < t; i++) {
		arr[i] = (int *)malloc(sizeof(int ) * n);
	}

	return arr;

}

// Print the result array.
void printArray(int **result, int n) {

	int i, j, t = Factorial(n);

	for (i = 0; i < t; i++) {
		for (j = 0; j < n; j++) {
			printf("%d", result[i][j]);
		}
		printf("\n");
	}

}
