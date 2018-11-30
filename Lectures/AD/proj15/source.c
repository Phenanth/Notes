#define MAX 100000

int matrixChain(int *p, int n, int **minNum, int **div) {

	int i;
	int j;
	int k;
	int num;

	// The result of matrix member muls itself are all zero.
	for (i = 0; i < n; i++) {
		minNum[i][i] = 0;
	}

	// Originally, the length of the matrix chain is 2.
	for (num = 2; num <= n; num++) {
		for (i = 0; i <= (n - num); i++) {
			j = i + num - 1;
			minNum[i][j] = MAX;
			for (k = i; k <= j - 1; k++) { // k means the place to divide.
				int temp = minNum[i][k] + minNum[k + 1][j] + p[i] * p[k + 1] * p[j + 1];
				if (temp < minNum[i][j]) {
					//printf("%d %d, %d %d\n", i, k, temp, minNum[i][j]);
					minNum[i][j] = temp;
					div[i][j] = k;
				}
			}
		}
		if (num == n) {
			break;
		}
	}

	return minNum[0][n - 1];

}

void printMatrixChain(int i, int j, int **div) {

	if (i == j) {
		printf("%s%d", "A", i + 1);
	} else {
		printf("(");
		printMatrixChain(i, div[i][j], div);
		printMatrixChain(div[i][j] + 1, j, div);
		printf(")");
	}

}

void printMatrix(int *p, int n) {

	int i;
	for (i = 0; i < n; i++) {
		printf("%d ", p[i]);
	}
	printf("\n");

}
