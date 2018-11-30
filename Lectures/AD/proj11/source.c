// The amount of the different  type of coins.
#define TYPES 3
// The number acts as infinite.
#define MAX 50000

// Making the changes.
int changeMaking(int *coins, int n) {

	int i;
	int *temp;

	temp = (int *)malloc(sizeof(int) * (n + 1));
	temp[0] = 0;

	for (i = 1; i <= n; i++) {
		int j = 0;
		int min = MAX;

		// When the money is enough,
		// and not all of the types are traversaled.
		while (j < TYPES && i >= coins[j]) {
			int index;
			index = i - coins[j];
			min = temp[index] < min ? temp[index] : min;
			j += 1;
		}

		temp[i] = min + 1;
	}

	return temp[n];

}

// Initilization
void init(int **coins, int *n) {

	scanf("%d", n);
	*coins = (int *)malloc(sizeof(int) * TYPES);
	(*coins)[0] = 1;
	(*coins)[1] = 3;
	(*coins)[2] = 4;

}
