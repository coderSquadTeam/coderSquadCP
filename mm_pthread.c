#include <stdio.h>
#include <pthread.h>
#include <time.h>
#include <sys/time.h>

#define THREADS 4
#define N 1024
#define MOD 20

void *slave(void *myid);

static int a[N][N];
static int b[N][N];
static int c[N][N];

int main(){
	srand(time(NULL));
	
	int i, j;
	struct timeval start, stop;
	pthread_t tid[THREADS];
	
	for(i = 0; i < N; i++){
		for (j = 0; j < N; j++){
			a[i][j] = 1 + (rand() % MOD);
			b[i][j] = 1 + (rand() % MOD);
			c[i][j] = 0;
		}
	}
	
	gettimeofday(&start, 0);
	
	for(i = 0; i < THREADS; i++){
		if(pthread_create(&tid[i], NULL, slave, (void *) i) != 0){
			perror("Pthread create fails");
		}
	}
	
	for(i = 0; i < THREADS; i++){
		if(pthread_join(tid[i], NULL) != 0){
			perror("Pthread join fails");
		}
	}
	
	gettimeofday(&stop, 0);
	
	printf("Matrix Multiplication: Pthread Code\n");
	printf("----------------------------------------\n");
	printf("Matrix A: %d X %d\n", N, N);
	printf("Matrix B: %d X %d\n", N, N);
	printf("Number of threads: %d\n", THREADS);
	printf("Time = %.6f\n", (stop.tv_sec+stop.tv_usec*1e-6)-(start.tv_sec+start.tv_usec*1e-6));
	
	return 0;
}

void *slave(void *myid){
	int rows, low, high;
	
	if (N >= THREADS) {
		rows = N / THREADS;
		low = (int) myid * rows;
		high = low + rows;
	} else {
		rows = 1;
		low = (int) myid;
		
		if (low >= N){
			high = low;
		} else {
			high = low + 1;
		}
	}
	
	int i, j, k;
	
	for(i = low; i < high; i++){
		for(j = 0; j < N; j++){
			for(k = 0; k < N; k++){
				c[i][j] += a[i][k] + b[k][j];
			}
		}
	}
}
