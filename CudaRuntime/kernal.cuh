__global__ void gpuAdd(int n, float* a, float* b);
int addUsingGPU();
const int N = 1 << 24;