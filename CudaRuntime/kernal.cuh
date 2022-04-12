__global__ void gpuAdd(int n, float* a, float* b);
int addUsingGPU();
const int N = 1 << 24;
const float A = 4;
const float B = 2;