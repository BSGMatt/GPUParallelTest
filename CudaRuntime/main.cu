//Running two versions of a function that adds two vectors together. 

#include <iostream>
#include <math.h>
#include <time.h>
#include "kernal.cuh"

/// Adds each element of a to each element of b. 
void add(int n, float* a, float* b) {
	for (int i = 0; i < n; i++) {
		b[i] = a[i] + b[i];
	}
}

//This code is run using the CPU. 
int addUsingCPU() {

	//keep track of how time the process took.
	clock_t start, end;
	start = clock();

	//Create two arrays that will be used as our vectors. 
	float* a = new float[N];
	float* b = new float[N];

	//Fill the two vectors
	for (uint32_t i = 0; i < N; i++) {
		a[i] = 1.0f;
		b[i] = 2.0f;
	}

	//add() will be the vector addition function
	add(N, a, b);

	end = clock();

	//Calculate the elapsed time
	double seconds = double(end - start) / double(1000000);

	//print the first 5 elements of b
	for (uint32_t i = 0; i < 5; i++) {
		printf("B[%d]: %f\n", i, b[i]);
	}

	printf("Process took %f seconds", seconds);

	//Free memory
	delete[] a;
	delete[] b;

	return 0;
}

int main() {

	printf("Adding with CPU: \n");

	addUsingCPU();

	printf("\n");

	addUsingGPU();
}