#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>


#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

__global__ void reduce(int* input, int n){
  unsigned int tid=threadIdx.x;
  unsigned int i=blockDim.x * blockIdx.x + threadIdx.x;
  unsigned int offset = blockDim.x * blockIdx.x;
  __syncthreads();
    for(unsigned int s=1; s<blockDim.x; s*=2){
      if(tid % (2*s)==0){
        input[i] = (i + s < offset + blockDim.x && i+s < n)? input[i] ^ input[i + s] : input[i];
        printf("input[%d]= %d offset= %ld\n",i,input[i],offset);
      }
      __syncthreads();
    }
}

int main(int argc, char** argv){
  struct timeval start, end, t_start, t_end;
  int i,n = atoi(argv[1]);
  int seed= atoi(argv[2]);
  int * array;
  int blocks;
  int result=0;
  int threads=10;
  array=(int*)malloc(n * sizeof(int));

  srand(seed);
  for(i=0;i<n;i++){
    array[i]=random();
    printf("a[%d]= %d\n",i,array[i]);
  }

  int *gpu_array;

  gettimeofday(&t_start, NULL);

  cudaMalloc(&gpu_array, n*sizeof(int));
  CUDA_ERROR_EXIT("cudaMalloc");

  cudaMemcpy(gpu_array, array, n*sizeof(int), cudaMemcpyHostToDevice);
  CUDA_ERROR_EXIT("cudaMemcpy");

  gettimeofday(&start, NULL);

  blocks= (n + threads -1)/threads;

  reduce<<<blocks,threads>>>(gpu_array,n);
  CUDA_ERROR_EXIT("kernel invocation");
  gettimeofday(&end, NULL);

  cudaMemcpy(array, gpu_array, n*sizeof(int), cudaMemcpyDeviceToHost);
  CUDA_ERROR_EXIT("memcpy");

  for(i=0;i<n;i+=threads){
    result = result ^ array[i];
    printf("result= %d\n",result);
  }
  gettimeofday(&t_end, NULL);
  printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
  cudaFree(gpu_array);

}
