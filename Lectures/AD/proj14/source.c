int *ActivitySelector(EVENTPOINTER events, int n, int *nrst){

	int i;
	int count; // Record how many events are in the  selected array.
	int *result; // Record which event is selected.

	// Initialization of the array.
	result = (int *)malloc(sizeof(int) * n);
	for (i = 0; i < n; i++) {
		result[i] = 0;
	}

	// Sort the event array by its finish time.
	qsort(events, n, sizeof(events[0]), cmp);
	printf("%s\n", "After sort:");
	printArray(events, n);

	// Record the selected events.
	count = 0;
	result[0] = 0;
	for (i = 1; i < n; i++) {
		if (events[i].start >= events[result[count]].finish) {
			result[++count] = i;
		}
	}
	*nrst = count + 1;

	return result;

}

int cmp(const void *p, const void *q) {
	return ((*(EVENTPOINTER)p).finish - (*(EVENTPOINTER)q).finish);
}

EVENTPOINTER Init(int *n) {

	int i;
	EVENTPOINTER events;

	scanf("%d", n);
	events = (EVENTPOINTER)malloc(sizeof(struct event) * (*n));
	for (i = 0; i < (*n); i++) {
		scanf("%d %d", &events[i].start, &events[i].finish);
	}

	return events;

}

void printResult(EVENTPOINTER events, int *result, int n) {

	int i;
	printf("%s\n", "Selected events:");
	for (i = 0; i < n; i++) {
		int index = result[i];
		printf("Event %d: %d-%d\n", index, events[index].start, events[index].finish);
	}

}

void printArray(EVENTPOINTER arr, int n) {

	int i;
	for (i = 0; i < n; i++) {
		printf("Event %d: %d %d\n", i, arr[i].start, arr[i].finish);
	}
	printf("\n");

}
