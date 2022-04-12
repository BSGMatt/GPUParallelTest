//This program is designed to demonstrate the functionality of GPUPU by 
//Running two versions of a function that adds two vectors together. 

#include <iostream>
#include <math.h>
#include <time.h>
#include <cuda_runtime.h>
#include <cuda.h>
#include "kernal.cuh"


/// Adds each element of a to each element of b. 

__global__ void gpuAdd(int n, float* a, float* b) {

	int index = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;
	for (int i = index; i < n; i += stride) {
		b[i] = a[i] + b[i];
	}
}

//This code is run using the GPU. 
int addUsingGPU() {

	//keep track of how time the process took.
	clock_t start, end;

	//Create two arrays containing the values that will be added together. 
	float* a, * b;
	cudaError_t malloc_a = cudaMallocManaged(&a, N * sizeof(float));
	cudaError_t malloc_b = cudaMallocManaged(&b, N * sizeof(float));

	//printf("cudaError for a: %d, cudaError for b: %d\n", malloc_a, malloc_b);

	for (uint32_t i = 0; i < N; i++) {
		a[i] = A;
		b[i] = B;
	}

	start = clock();

	//gpuAdd() will be the vector addition function
	gpuAdd<<<1, 1024>>>(N, a, b);
	//--//

	//printf("Last Error code: %d\n", cudaGetLastError());

	cudaDeviceSynchronize();

	end = clock();

	//Calculate the elapsed time
	double seconds = double(end - start) / double(10000000);

	//print the first 5 elements of b
	for (uint32_t i = 0; i < 5; i++) {
		printf("b[%d]: %.8f\n", i, b[i]);
	}


	printf("Process took %f seconds", seconds);

	//Free memory
	cudaFree(a);
	cudaFree(b);

	return 0;
}