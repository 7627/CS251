#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>
#include<math.h>

#define SEED 0x7457
#define MAX_THREADS 64
#define USAGE_EXIT(s) do{\
                    printf("Usage: %s <number of elements> <number of threads> \n%s\n",argv[0],s);\
                    exit(-1);\
}while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct thread_param{
                       pthread_t tid;
                       int *array;
                       int size;
                       int skip;
		                   int thread_ctr;
                       int max;
                       int max_index;
};



int prime(int a){
  if(a==0) return 0;
  int i;
  for(i=2;i<=sqrt(a);i++){
    if(a%i==0){
      return 0;
    }
  }
  return 1;
}

void* find_max(void *arg){
  struct thread_param* param=(struct thread_param*)arg; //convert a pointer to struct pointer
  int ctr=param->thread_ctr; //from where to start reading
  param->max=prime(param->array[ctr])? param->array[ctr] : -1; //initialize max and max_index
  param->max_index=prime(param->array[ctr])? ctr : -1;
  ctr+=param->skip;
  while(ctr<param->size){
    if(param->array[ctr]>param->max && prime(param->array[ctr])){
      param->max=param->array[ctr];
      param->max_index=ctr;
    }
    ctr+=param->skip;
  }
  // printf("find_max function= %d\n",param->max);
  return NULL;
}

int main(int argc,char** argv){
  struct thread_param *params;
  int num_elements,num_threads;
  num_elements = atoi(argv[1]);
  num_threads = atoi(argv[2]);
  int*a = malloc( num_elements * sizeof( int ) );
  int ctr=0, max=0, max_index=0;
  struct timeval start, end; //to measure time

  srand(SEED);
  for(ctr=0;ctr<num_elements;ctr++){
    a[ctr]=random();
    if(prime(a[ctr])){
      printf("%d %d %d\n",ctr,a[ctr],prime(a[ctr]));
    }
  }

    params = malloc(num_threads * sizeof(struct thread_param));
    bzero(params, num_threads * sizeof(struct thread_param)); //fills itne zeros in params named pointer

    gettimeofday(&start, NULL);

    for(ctr=0;ctr<num_threads;++ctr){
      struct thread_param *param = params + ctr;
      param->skip=num_threads;
      param->size=num_elements;
      param->thread_ctr=ctr;
      param->array=a;

      pthread_create(&param->tid, NULL, find_max, param);
    }

    for(ctr=0; ctr < num_threads; ++ctr){
      struct thread_param * param = params + ctr;
      pthread_join(param->tid, NULL);
      // printf("ctr= %d param->max= %d max= %d\n",ctr,param->max,max);
      if(param->max > max ){
        max = param->max;
        max_index = param->max_index;
      }
    }
    gettimeofday(&end, NULL);
    printf("max= %d, max_index= %d \n",max,max_index);
    printf("Time taken = %ld microsecs\n", TDIFF(start, end));
    free(a);
    free(params);

















}
