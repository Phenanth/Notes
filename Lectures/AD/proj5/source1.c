// Force algorithm.
void Queen_Force() {
	int a, b, c, d, e, f, j, h;

	for (a = 1; a <= NUM; a++) {
		result[0] = a;
		for (b = 1; b <= NUM; b++) {
			result[1] = b;
			for (c = 1; c <= NUM; c++) {
				result[2] = c;
				for (d = 1; d <= NUM; d++) {
					result[3] = d;
					for (e = 1; e <= NUM; e++) {
						result[4] = e;
						for (f = 1; f <= NUM; f++) {
							result[5] = f;
							for (j = 1; j <= NUM; j++) {
								result[6] = j;
								for (h = 1; h <= NUM; h++) {
									result[7] = h;
									if (fnJudge(NUM)) {
										count++;
										printResult();
									}
								}
							}
						}
					}
				}
			}
		}
	}

	printf("\n");

}
