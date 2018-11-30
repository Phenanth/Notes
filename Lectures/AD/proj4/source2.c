// Johnson-Trotter algorithm.
int **fnJohnsonTrotter(int n) {

	int **arr, *dir, *tmp, i, t = Factorial(n), pos = 1;

	arr = initArray(n);
	for (i = 0; i < n; i++) {
		arr[0][i] = i + 1;
	}

	dir = (int *) malloc(sizeof(int) * n);
	tmp = (int *)malloc(sizeof(int) * n);
	for (i = 0; i < n; i++) {
		tmp[i] = arr[0][i];
	}

	while (notCompleted(tmp, dir, n)) {
		int maxOne = maxOneInArray(tmp, dir, n), index = 0;
		for (i = 0; i < n; i++) {
			if (tmp[i] == maxOne) {
				index = i;
			}
		}

		if (dir[index] == 0) {
			int temp;
			temp = tmp[index - 1];
			tmp[index - 1] = tmp[index];
			tmp[index] = temp;
			dir[index] = dir[index - 1];
			dir[index - 1] = 0;
		} else if (dir[index] == 1) {
			int temp;
			temp = tmp[index + 1];
			tmp[index + 1] = tmp[index];
			tmp[index] = temp;
			dir[index] = dir[index + 1];
			dir[index + 1] = 1;
		}

		for (i = 0; i < n; i++) {
			if (tmp[i] > maxOne) {
				if (dir[i] == 1) {
					dir[i] = 0;
				} else {
					dir[i] = 1;
				}
			}
		}

		for (i = 0; i < n; i++) {
			arr[pos][i] = tmp[i];
		}
		pos++;

	}

	return arr;

}

// Find if there is any numbers can be moved.
int notCompleted(int *tmp, int *dir, int n) {
	int i;
	for (i = 0; i < n; i++) {
		if (i != 0 && dir[i] == 0) {
			if (tmp[i] > tmp[i - 1]) {
				return 1;
			}
		}
		if (i != (n - 1) && dir[i] == 1) {
			if (tmp[i] > tmp[i + 1]) {
				return 1;
			}
		}
	}
	return 0;
}

// Find the number which is both the biggest and can be moved.
int maxOneInArray(int *tmp, int *dir, int n) {
	int i, max = 0;
	for (i = 0; i < n; i++) {
		if (i != 0 && dir[i] == 0) {
			if (max < tmp[i] && tmp[i] > tmp[i - 1]) {
				max = tmp[i];
			}
		}
		if (i != (n - 1) && dir[i] == 1) {
			if (max < tmp[i] && tmp[i] > tmp[i + 1]) {
				max = tmp[i];
			}
		}
	}
	return max;
}
