// Continuous Increasing Interger Algorithm
int Increasing (int m, int n) {

	int t = 0, result = 0;

	if (m == 1 || n == 1) {
		return 1;
	}

	// #1
	t = m > n ? n : m;

	while (t >= 2) {

		// #2&#4
		if (m % t != 0) {
			t -= 1;
			continue;
		}

		// #3&#4
		if (n % t == 0) {
			result = t;
			break;

		} else {
			t -= 1;
		}

	}

	// The two numbers are relatively prime numbers.
	if (t < 2) {
		result = t;
	}

	return result;
	
}
