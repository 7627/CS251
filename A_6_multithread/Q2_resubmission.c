#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<pthread.h>

// #define THREADS 1
#define BLOCK_SIZE 64
pthread_mutex_t lock;

struct account{
  int acc_no;
  double bal;
};
typedef struct account acc;
acc* accounts;

struct transaction{
  int sr_no;
  int type;
  double value;
  int ac1,ac2;
};
typedef struct transaction txn;

txn* init;

void* function(void* arg){
  txn* endptr= (txn *)arg;
  txn* cptr;
  while(1){
    pthread_mutex_lock(&lock);
    if(init>=endptr){
      pthread_mutex_unlock(&lock);
      break;
    }
    cptr=init;
    init++;

    switch(cptr->type){
      case 1:
        (accounts-1001+cptr->ac1)->bal += (cptr->value * 0.99);
        // printf("after adding %lf to %d : %lf\n",cptr->value,(accounts-1001+cptr->ac1)->acc_no,(accounts-1001+cptr->ac1)->bal);
        break;
      case 2:
        (accounts-1001+cptr->ac1)->bal -= (cptr->value * 1.01);
        // printf("after withdrawing %lf from %d : %lf\n",cptr->value,(accounts-1001+cptr->ac1)->acc_no,(accounts-1001+cptr->ac1)->bal);
        break;
      case 3:
        (accounts-1001+cptr->ac1)->bal*=1.071;
        // printf("adding interest of 7.4 to %d :  %lf\n",(accounts-1001+cptr->ac1)->acc_no,(accounts-1001+cptr->ac1)->bal);
        break;
      case 4:
      (accounts-1001+cptr->ac1)->bal -= (cptr->value * 1.01);
      (accounts-1001+cptr->ac2)->bal += (cptr->value * 0.99);
      // printf("after transfering %lf from %d bal in :  %lf\n",cptr->value,(accounts-1001+cptr->ac1)->acc_no,(accounts-1001+cptr->ac1)->bal);
      break;
    }
    pthread_mutex_unlock(&lock);
  }
  pthread_exit(NULL);
}



int main(int argc, char **argv){
  int THREADS=atoi(argv[4]);
  int num_txns,num_accounts;
  txn* txns;
  FILE* tn;
  FILE* ac;
  pthread_t threads[THREADS];
  int i;

  num_txns=atoi(argv[3]);
  num_accounts=10000;

  txns = malloc(num_txns * sizeof(txn));
  accounts= malloc(num_accounts * sizeof(acc));

  tn=fopen(argv[2], "r");
  ac=fopen(argv[1], "r");
  // printf("1\n\n");
  txn* temp=txns;
  for(i=0; i<num_txns; i++){
    fscanf(tn,"%d", &(temp->sr_no));
    fscanf(tn,"%d", &(temp->type));
    fscanf(tn,"%lf", &(temp->value));
    fscanf(tn,"%d", &(temp->ac1));
    fscanf(tn,"%d", &(temp->ac2));
    temp++;
  }
  // printf("2\n\n");
  acc* Temp=accounts;
  for(i=0; i<num_accounts; i++){
    fscanf(ac,"%d",&(Temp->acc_no));
    fscanf(ac, "%lf", &(Temp->bal));
    Temp++;
  }
  // printf("3\n\n");
  pthread_mutex_init(&lock,NULL);

  init=txns;
  for(i=0;i<THREADS;i++){
    if(pthread_create(&threads[i], NULL, function, temp) != 0){
          printf("error\n\n");
          perror("pthread_create");
          exit(-1);
    }
  }
  // printf("4\n\n");
  for(i=0;i<THREADS;i++){
    pthread_join(threads[i], NULL);
  }
  // printf("5\n\n");
  for(i=0;i<num_accounts;i++){
    printf("%d %.2lf\n",(accounts+i)->acc_no,(accounts+i)->bal);
  }

  return 0;





















}
