// Arithmetic Algorithm
int Arithmetic(int m, int n) {

	int arr1[MAX] = {0}, arr2[MAX] = {0}, result = 1, i = 0;

	// #1&#2
	primeFactor(arr1, m);
	primeFactor(arr2, n);

	// #3 & #4: Multiply the same factors.
	for (i = 0; i < MAX; i++) {

		if (arr1[i] > 0 && arr2[i] > 0) {
			result *= i;
			arr1[i] -= 1;
			arr2[i] -= 1;
			i -= 1;
		}

	}

	return result;
	
}

// Store the prime factors of a number in the array.
void primeFactor(int arr[], int x) {

	int i = 0;

	if (x == 1) {
		arr[1] += 1;
		return;
	}

	while (!isPrime(x)) {

		for (i = 2; i < (x / 2); i++) {

			if (isPrime(i) && x % i == 0) {

				arr[i] += 1;
				x /= i;
				break;

			}
		}

	}

	arr[x] += 1;

}

// Judge if it is a prime number.
int isPrime(int x) {

	int i;

	for (i = 2; i <= x; i++) {

		if (x % i == 0) {
			break;
		}

	}

	if (x == i) {
		return 1;
	} else {
		return 0;
	}

}

// Print the array, for debugging.
void printArray(int arr[]) {

	int i;

	for (i = 0; i < MAX; i++) {
		printf("%d ", arr[i]);
	}

	printf("\n");

}
