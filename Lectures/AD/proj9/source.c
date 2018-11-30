// Gauss algorithm.
int **forwardElimination(int **arr, int row) {

	int i, j, k;

	for (i = 0; i < row; i++) {
		for (j = i + 1; j < row; j++) {
			for (k = row; k > i - 1; k--) {
				if (arr[i][i]) {
					arr[j][k] = arr[j][k] - arr[i][k] * arr[j][i] / arr[i][i];
				}
				else {
					arr[j][k] = 0;
				}
				//printArray(arr, row);
			}
		}
	}

	return arr;

}

int switchRow(int **arr, int row, int n) {
	int i, j, flag = 0;
	for (i = 0; i < n; i++) {
		if (i != row && arr[i][i] != 0) {
			for (j = 0; j < n + 1; j++) {
				int temp;
				temp = arr[row][j];
				arr[row][j] = arr[i][j];
				arr[i][j] = temp;
			}
			flag = 1;
			break;
		}
	}
	return flag;
}

void printResult(int **arr, int row, int flag) {

	int i, j, non = 0, ctn = 0;

	// Should check if gause algorithm will return a formated array.
	// Or else I need to optimize the way answer is checked.
	// Also need to check if this function can cover all the posibilities.
	for (i = 0; i < row; i++) {
		int allZero = 1;
		int allZeroExpt = 1;
		for (j = 0; j < row + 1; j++) {
			if (arr[i][j] != 0) {
				allZero = 0;
				if (j != row) {
					allZeroExpt = 0;
				}
				else {
					break;
				}
			}
			else if (arr[i][j] == 0 && j == row) {
				allZeroExpt = 0;
			}
		}
		if (allZeroExpt) {
			non = 1;
			break;
		}
		if (allZero) {
			ctn++;
		}
	}

	if (non) {
		printf("%s", "Oh,it's impossible~!!");
	}
	else if (ctn == 0) {
		printf("%d", ctn + 1);
	}
	else {
		printf("%.0lf", pow(2.0, (double)ctn));
	}

	if (flag) {
		printf("\n");
	}

}

int **init(int *n) {

	int i, j;
	int *alt, *alt1, *alt2;
	int **temp;
	int a, b;

	scanf("%d", n);
	alt = (int *)malloc(sizeof(int) * (*n));
	alt1 = (int *)malloc(sizeof(int) * (*n));
	alt2 = (int *)malloc(sizeof(int) * (*n));
	temp = (int **)malloc(sizeof(int *)*(*n));
	for (i = 0; i < *n; i++) {
		temp[i] = (int *)malloc(sizeof(int) * (*n + 1));
	}

	// Initilize the array with 0.
	for (i = 0; i < *n; i++) {
		for (j = 0; j < (*n + 1); j++) {
			temp[i][j] = 0;
		}
	}

	// Each switch can effect it self.
	for (i = 0; i < *n; i++) {
		temp[i][i] = 1;
	}

	// Generate the altered result.
	for (i = 0; i < *n; i++) {
		scanf("%d", &(alt1[i]));
	}
	for (i = 0; i < *n; i++) {
		scanf("%d", &(alt2[i]));
	}
	for (i = 0; i < *n; i++) {
		alt[i] = (alt1[i] == 1 && alt2[i] == 0) || (alt1[i] == 0 && alt2[i] == 1);
	}

	// Add relationship between switches.
	do {
		scanf("%d %d", &a, &b);
		if (a == 0 && b == 0) {
			break;
		}
		temp[a - 1][b - 1] = 1;
	} while (1);

	// Altered array.
	// If needed, cut this part and paste in the gause algorithm.
	for (i = 0; i < *n; i++) {
		temp[i][(*n)] = alt[i];
	}

	return temp;

}

void printAlt(int *arr, int row) {
	int i;
	for (i = 0; i < row; i++) {
		printf("%d ", arr[i]);
	}
	printf("\n");
}

void printArray(int **arr, int row) {
	int i, j;
	for (i = 0; i < row; i++) {
		for (j = 0; j < row + 1; j++) {
			printf("%d ", arr[i][j]);
		}
		printf("\n");
	}
	printf("\n");
}
