#include <stdio.h>
#include <time.h>
#include <sys/time.h>

#define N 1024
#define MOD 20

int main (){
	srand(time(NULL));
	
	static int a[N][N], b[N][N], c[N][N];
	int i, j, k;
	struct timeval start, stop;
	
	for(i = 0; i < N; i++){
		for (j = 0; j < N; j++){
			a[i][j] = 1 + (rand() % MOD);
			b[i][j] = 1 + (rand() % MOD);
			c[i][j] = 0;
		}
	}
	
	gettimeofday(&start, 0);
	
	for(i = 0; i < N; i++){
		for (j = 0; j < N; j++){
			for (k = 0; k < N; k++){
				c[i][j] += a[i][k] * b[k][j];
			}	
		}
	}
	
	gettimeofday(&stop, 0);
	
	printf("Matrix Multiplication: Sequential Code\n");
	printf("----------------------------------------\n");
	printf("Matrix A: %d X %d\n", N, N);
	printf("Matrix B: %d X %d\n", N, N);
	printf("Time = %.6f\n", (stop.tv_sec+stop.tv_usec*1e-6)-(start.tv_sec+start.tv_usec*1e-6));
	
	return 0;
}
