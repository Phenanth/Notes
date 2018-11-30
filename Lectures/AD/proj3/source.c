// Judge if all the points are in the same side of a line.
int isAllSameSide(POINTPOINTER arr, int n, int i, int j) {

	int x1 = arr[i].x, y1 = arr[i].y, x2 = arr[j].x, y2 = arr[j].y;
	int a = y2 - y1, b = x1 - x2, c = x1 * y2 - y1 * x2;
	int m = 0, index = 0, REAL = 1, first = 1;

	for (m = 0; m < n; m++) {
		if (m != i && m != j) {
			if (!isSameSide(a, b, c, arr[m].x, arr[m].y, &index, &first)) {
				REAL = 0;
				break;
			}
		}
	}

	if (!REAL) {
		return 0;
	} else {
		return 1;
	}

}

// Judge if one single point is in the same side. 
int isSameSide(int a, int b, int c, int x, int y, int* index, int* first) {

	if (*first == 1) {
		*index = (a * x + b * y >= c);
		*first = 0;
		return 1;
	}

	if ((a * x + b * y >= c) == *index) {
		return 1;
	} else {
		return 0;
	}

}

// Initilization of the set of the points.
POINTPOINTER init(int* n) {

	int i = 0;
	POINTPOINTER arr;

	printf("%s\n", "The numbers of the points is:");
	scanf("%d", n);

	arr = (POINTPOINTER) malloc(*n * sizeof(struct point));
	
	printf("%s\n", "The points are:");

	for (i = 0; i < *n; i++) {
		scanf("%d %d", &(arr[i].x), &(arr[i].y));
	}

	return arr;

}

// Print the array, for debugging.
void printArray(POINTPOINTER arr, int n) {

	int i = 0;

	for (i = 0; i < n; i++) {
		printf("(%d, %d)\n", arr[i].x, arr[i].y);
	}

}
