#define MAX 100

// Recursively find two closest points in a point array.
POINTPOINTER closestTwoPoints(POINTPOINTER arr, int a, int b, double *dmin) {

	POINTPOINTER result = NULL;
	// The amount of the points.
	int n = b - a + 1;

	// If the function was called the first time,
	// sort the point array by x coordinate.
	if (n == 1) {
		*dmin = 100000;
		return NULL;
	}
    else if (n == 2) {
		// The condition to stop.
		*dmin = calDistance(arr[a], arr[b]);
		result = (POINTPOINTER)malloc(sizeof(POINT) * 2);
		result[0].x = arr[a].x;
		result[0].y = arr[a].y;
		result[1].x = arr[b].x;
		result[1].y = arr[b].y;
	}
	else {
		qsort(arr, (b - a + 1), sizeof(POINT), comp_x);
		int mid, i, cnt;
		double dminL = *dmin, dminR = *dmin, dminT, midX;
		POINTPOINTER tempL, tempR, temp = NULL, t = NULL;

		// Find the shortest distance between the 
		// left & right section of the area.
		mid = (a + b) / 2;
		tempL = closestTwoPoints(arr, a, mid, &dminL);
		tempR = closestTwoPoints(arr, mid + 1, b, &dminR);
		dminT = dminL < dminR ? dminL : dminR;

		// Array temp may need initilization...
		temp = (POINTPOINTER)malloc(sizeof(POINT) * n);

		// Calculate the middle x coordinate(midX).
		qsort(arr, (b - a + 1), sizeof(POINT), comp_x);
		midX = arr[a].x + (arr[b].x - arr[a].x) / 2.0;

		// Get the point array(arrT) that its x's ranges is: 
		// (midX-dminT, midX+dminT)
		for (i = a, cnt = 0; i <= b; i++) {
			if (arr[i].x < (midX - dminT)) {
				continue;
			}
			else if (arr[i].x > midX + dminT) {
				break;
			}
			else {
				temp[cnt].x = arr[i].x;
				temp[cnt].y = arr[i].y;
				cnt += 1;
			}
		}

		t = (POINTPOINTER)malloc(sizeof(POINT) * cnt);
		for (i = 0; i < cnt; i++) {
			t[i].x = temp[i].x;
			t[i].y = temp[i].y;
		}

		// Sort the temp array by y coordinate.
		qsort(t, cnt, sizeof(POINT), comp_y);

		// Judge if there are two points in the temp array
		// that is closer than the former two.
		double minDis = dminT;

		if (dminL < dminR) {
			result = tempL;
		}
		else {
			result = tempR;
		}

		for (i = 0; i < cnt; i++) {
			int j;
			for (j = 0; j < 6 && j < cnt; j++) {
				if (i != j && (calDistance(t[i], t[j]) < minDis) ) {
					minDis = calDistance(t[i], t[j]);
					result[0].x = t[i].x;
					result[0].y = t[i].y;
					result[1].x = t[j].x;
					result[1].y = t[j].y;
				}
			}
		}
		*dmin = minDis;

	}

	return result;

}

int comp_x(const void *p, const void *q) {
	return ((((POINTPOINTER)p)->x) - (((POINTPOINTER)q)->x));
}

int comp_y(const void *p, const void *q) {
	return ((((POINTPOINTER)p)->y) - (((POINTPOINTER)q)->y));
}

double calDistance(POINT a, POINT b) {
	return sqrt(pow((b.x - a.x), 2) + pow((b.y - a.y), 2));
}

// Generate a random number;
int Random(int a, int b) {

	int cor = 0;
	cor = rand() % (b - a + 1) + a;
	//printf("%s%d\n", "Random number: ", cor);
	return cor;

}

int isCompetive_x(POINTPOINTER arr, int n, int x) {
	int i;
	for (i = 0; i < n; i++) {
		if (x == arr[i].x) {
			return 1;
		}
	}
	return 0;
}

int isCompetive_y(POINTPOINTER arr, int n, int y) {
	int i;
	for (i = 0; i < n; i++) {
		if (y == arr[i].y) {
			return 1;
		}
	}
	return 0;
}

// Generate random points between 0 to MAX(Using macro definition).
POINTPOINTER generatePoints(int n) {

	int i, j;
	POINTPOINTER temp = NULL;
	temp = (POINTPOINTER)malloc(sizeof(POINT) * n);

	srand((unsigned)time(NULL));
	for (i = 0; i < n; i++) {
		int tx, ty;
		do {
			tx = Random(1, MAX);
			ty = Random(1, MAX);
		} while (isCompetive_x(temp, i, tx) && isCompetive_y(temp, i, ty));
		temp[i].x = tx;
		temp[i].y = ty;
		//printf("%d %d\n", temp[i].x, temp[i].y);
	}

	return temp;
}

void printArray(POINTPOINTER arr, int n) {

	int i;
	for (i = 0; i < n; i++) {
		printf("(%d, %d) ", arr[i].x, arr[i].y);
	}
	printf("\n");

}
