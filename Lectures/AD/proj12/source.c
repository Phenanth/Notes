#define MIN -10000

int *cutRodDP(int *price, int length, int *result) {

	int i, j;
	int *dp;
	int *temp;
	int *resolutionT;

	dp = (int *)malloc(sizeof(int) * (length + 1));
	resolutionT = (int *)malloc(sizeof(int) * (length));
	dp[0] = 0;
	for (i = 0; i< length; i++) {
		resolutionT[i] = 0;
	}

	// For each length, find the max income.
	for (i = 1; i <= length; i++) {
		int maxT = MIN;
		int count = 0;
		temp = (int *)malloc(sizeof(int) * i);
		for (j = 1; j <= i; j++) {
			//maxT = isMax(maxT, dp[i - j] + price[j - 1]);
			if (maxT < dp[i - j] + price[j - 1]) {
				temp[0] = j;
				temp[1] = length - j;
				maxT = dp[i - j] + price[j - 1];
			} else {
				continue;
			}
		}
		resolutionT = temp;
		dp[i] = maxT;
	}

	*result = dp[length];
	return resolutionT;

}

int isMax(int a, int b) {
	return a > b ? a : b;
}
