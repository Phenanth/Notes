// 欧几里得算法
int Euclid(int m, int n) {

	int r = 0;

	// #1
	if (n == 0) {
		return m;
	}

	while (n != 0) {

		// #1
		if (m % n == 0) {
			break;
		}

		// #2&#3
		r = m % n;
		m = n;
		n = r;

	}

	return n;

}
