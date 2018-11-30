// Recursive algorithm.
void Queen_Recur(int row) {

	int i;

	if (row == NUM) {
		count++;
		printResult();
		return ;
	}

	for (i = 0; i < NUM; i++) {
		result[row] = i + 1;
		if (fnRowJudge(row)) {
			Queen_Recur(row + 1);
		}
	}

}
