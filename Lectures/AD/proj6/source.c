void nim(int n, int choice) {

	int m;
	int m_pc = 0;

	while(n > 0) {

		if (choice) {
			m = inputMatch(n);
			n -= m;
			choice = 0;
		} else {
			srand((int)time(0));
			m_pc = random(4);
			if (m_pc > n) {
				m_pc = n;
			}
			n -= m_pc;
			printf("%s%d%s\n", "Computer had taken ", m_pc, " matches.");
			choice = 1;
		}

	}

	if (choice) {
		printf("%s\n", "Computer Win!");
	} else {
		printf("%s\n", "You Win!");
	}

}

int inputMatch(int n) {

	int m = 1;
	int ninput = 1;

	printf("%s%d\n", "Now the amount of the matches is:", n);
	do {

		if (m < 1 || m > 4) {
			printf("%s\n", "You can only take 1~4 matches.");
		} else if (m > n && !ninput) {
			printf("%s%d%s\n", "It's only ", n, " matches left.");
		}

		printf("%s", "Input how many matches you want to take: ");
		scanf("%d", &m);
		ninput = 0;

	} while(m < 1 || m > 4 || (m > n));

	return m;

}

int init() {

	srand((int)time(0));
	return random(30) + 10;

}
