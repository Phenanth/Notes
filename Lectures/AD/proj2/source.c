void Hanoi(int n, char a, char b, char c) {

	if (n == 1) {
		printf("%c -> %c\n", a, c);
		return;
	}

	Hanoi(n - 1, a, c, b);
	printf("%c -> %c\n", a, c);
	Hanoi(n - 1, b, a, c);

}
