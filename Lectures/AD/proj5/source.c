// Initilization of the result array.
void init() {

	int i;
	result = (int *)malloc(sizeof(int) * NUM);

	for (i = 0; i < NUM; i++) {
		result[i] = 0;
	}

}

// Clear the result array.
void clear(int index) {

	int i;

	for (i = index; i < NUM; i++) {
		result[i] = 0;
	}

}

// Print the result array.
void printResult() {

	int i;

	printf("%s%d:\n","Method ", count);
	for (i = 0; i < NUM; i++) {
		printf("%d ", result[i]);
	}

	printf("\n");

}

// Judge the whole finished array.
int fnJudge(int num) {

	int i;
	for (i = 0; i < num; i++) {
		if (!fnRowJudge(i)) {
			return 0;
		}
	}

	return 1;

}

// Judge one row of the array.
int fnRowJudge(int row) {

	int i;
	for (i = 0; i < row; i++) {
		if (result[i] == result[row] || abs(result[i] - result[row]) == abs(i - row)) {
			return 0;
		}
	}
	return 1;

}
