// Decrese and Conquer algorithm.
int **fnDecrease_1(int n) {
	int **arr, t = Factorial(n), i;

	arr = initArray(n);

	if (n == 1) {
		arr[0][0] = 1;
	} else {
		int **temp, *tmp, index, i, j, k, p, len = 1;
		temp = fnDecrease_1(n - 1);
		tmp = (int *)malloc(sizeof(int) * (n - 1));

		index = 0;

		for (i = 1; i <= (n - 1); i++) {
			len *= i;
		}

		for (i = 0; i < len; i++) {
			tmp = temp[i];
			for (j = 0; j < n; j++) {
				arr[index][j] = n;
				for (k = 0, p = 0; k < n && p < (n - 1); k++) {
					if (arr[index][k] != n) {
						arr[index][k] = tmp[p];
						p++;
					}
				}
				index++;
			}
		}
	}
	return arr;
}
