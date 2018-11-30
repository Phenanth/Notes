
int **LCS(char *str1, char* str2) {

	int i;
	int j;
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int **result;
	int **length;

	// Initilization.
	result = generateArray(len1, len2);
	length = generateArray(len1, len2);


	// Record state and length of LCS.
	// Dealing with the first row and column:
	if (str1[0] == str2[0]) {
		length[0][0] = 1;
		result[0][0] = 1;
	}
	else {
		length[0][0] = 0;
		result[0][0] = 2;
	}

	for (i = 1; i < len2; i++) {
		if (str1[0] == str2[i]) {
			length[0][i] = 1;
			result[0][i] = 1;
		}
		else if (result[0][i - 1] == 1 || result[0][i - 1] == 3) {
			length[0][i] = 0;
			result[0][i] = 3;
		}
		else {
			length[0][i] = 0;
			result[0][i] = 2;
		}
	}

	for (i = 1; i < len1; i++) {
		if (str1[i] == str2[0]) {
			length[i][0] = 1;
			if (result[i - 1][0] == 2 && i > 1) {
				result[i][0] = 2;
			} else {
				result[i][0] = 1;
			}
		}
		else if (result[i - 1][0] == 1 || result[i - 1][0] == 2) {
			length[i][0] = 0;
			result[i][0] = 2;
		}
		else {
			length[i][0] = 0;
			result[i][0] = 3;
		}
	}

	// Dealing with other rows and columns:
	// Problem: When calculating length, the length below haven't been calculated,
	// which means the direction result array won't be correctly generated.
	for (i = 1; i < len1; i++) {
		for (j = 1; j < len2; j++) {
			if (str1[i] == str2[j]) {
				length[i][j] = length[i - 1][j - 1] + 1;
				result[i][j] = 1; // 1 for choosen.
			}
			else if (length[i - 1][j] > length[i][j - 1]) {
				length[i][j] = length[i - 1][j];
				result[i][j] = 2; // 2 for up;
			}
			else if (length[i - 1][j] < length[i][j - 1]) {
				length[i][j] = length[i][j - 1];
				result[i][j] = 3; // 3 for left;
			}
		}
	}

	return result;

}

void structureSequence(int **result, char *str1, int len1, int len2) {

	if (len1 == -1 || len2 == -1) {
		return;
	}

	if (result[len1][len2] == 1) {
		printf("%c", str1[len1]);
		structureSequence(result, str1, len2 - 1, len2 - 1);
	}
	else if (result[len1][len2] == 2) {
		structureSequence(result, str1, len1 - 1, len2);
	}
	else {
		structureSequence(result, str1, len1, len2 - 1);
	}

}

int **generateArray(int len1, int len2) {
	int i;
	int j;
	int **arr = NULL;
	arr = (int **)malloc(sizeof(int *) * len1);
	for (i = 0; i < len1; i++) {
		arr[i] = (int *)malloc(sizeof(int) * len2);
	}
	for (i = 0; i < len1; i++) {
		for (j = 0; j < len2; j++) {
			arr[i][j] = 0;
		}
	}
	return arr;
}

void printArray(int **result, int len1, int len2) {
	int i;
	int j;
	for (i = 0; i < len1; i++) {
		for (j = 0; j < len2; j++) {
			printf("%2d ", result[i][j]);
		}
		printf("\n");
	}
	printf("\n");
}
