#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>



#define MAX_THREADS 64



struct account{
  int acc_no;
  float bal;
};
typedef struct account acc;
acc* accounts;

struct transaction{
  int sr_no;
  int type;
  float value;
  int ac1,ac2;
  int skip, size;
};
typedef struct transaction txn;


void* function(void* arg){
  txn* temp= (txn*)arg;
  static int n=0;
  int i;
  for(i=n; i<temp->size; i+=temp->skip){
    printf("%d %d %f %d %d %d %d\n",temp->sr_no,temp->type,temp->value,temp->ac1,temp->ac2,temp->skip,temp->size );
    switch(temp->type){
      case 1:
        printf("initial bal: %f\n",(accounts-1001+temp->ac1)->bal);
        (accounts-1001+temp->ac1)->bal += (temp->value * 0.99);
        printf("txn value= %f ac1= %d ac2= %d\n",temp->value,temp->ac1,temp->ac2);
        printf("final bal: %f\n",(accounts-1001+temp->ac1)->bal);
        printf("\n");
        break;
      case 2:
        printf("initial bal: %f\n",(accounts-1001+temp->ac1)->bal);
        (accounts-1001+temp->ac1)->bal -= (temp->value * 1.01);
        printf("txn value= %f ac1= %d ac2= %d\n",temp->value,temp->ac1,temp->ac2);
        printf("final bal: %f\n",(accounts-1001+temp->ac1)->bal);
        printf("\n");
        break;
      case 3:
        printf("initial bal: %f\n",(accounts-1001+temp->ac1)->bal);
        (accounts-1001+temp->ac1)->bal*=1.071;
        printf("txn value= %f ac1= %d ac2= %d\n",temp->value,temp->ac1,temp->ac2);
        printf("final bal: %f\n",(accounts-1001+temp->ac1)->bal);
        printf("\n");
        break;
      case 4:
        printf("initial bal: %f\n",(accounts-1001+temp->ac1)->bal);
        printf("initial bal: %f\n",(accounts-1001+temp->ac2)->bal);
        (accounts-1001+temp->ac1)->bal -= (temp->value * 1.01);
        (accounts-1001+temp->ac2)->bal += (temp->value * 0.99);
        printf("txn value= %f ac1= %d ac2= %d\n",temp->value,temp->ac1,temp->ac2);
        printf("final bal: %f\n",(accounts-1001+temp->ac1)->bal);
        printf("final bal: %f\n",(accounts-1001+temp->ac2)->bal);
        printf("\n");
        break;

    }
    temp+= temp->skip;
  }
  n++;
  return NULL;
}







int main(int argc, char** argv){
  int num_txns,num_accounts;
  txn* txns;
  FILE* tn;
  FILE* ac;
  int THREADS= atoi(argv[4]);
  pthread_t threads[THREADS];

  num_txns=atoi(argv[3]);
  num_accounts=10000;
  // txns->skip=atoi(argv[4]);
  // txns->size=num_txns;
  txns = malloc(num_txns * sizeof(txn));
  accounts= malloc(num_accounts * sizeof(acc));
  /*scanning txn.txt file*/
  tn=fopen(argv[1], "r");
  ac=fopen(argv[2], "r");

  txn* temp=txns;
  for(int i=0; i<num_txns; i++){
    fscanf(tn,"%d", &(temp->sr_no));
    fscanf(tn,"%d", &(temp->type));
    fscanf(tn,"%f", &(temp->value));
    fscanf(tn,"%d", &(temp->ac1));
    fscanf(tn,"%d", &(temp->ac2));
    temp->skip=THREADS;
    temp->size=num_txns;
    temp++;
  }
  // printf("acc_no= %d type= %d value=%f \n",txns->ac1, txns->type, (txns)->value);

  acc* Temp=accounts;
  for(int i=0; i<num_accounts; i++){
    fscanf(ac,"%d",&(Temp->acc_no));
    fscanf(ac, "%f", &(Temp->bal));
    Temp++;
  }
  // printf("%f\n",(accounts+txns->ac1-1001)->bal);




  temp=txns;
  for(int i=0; i<THREADS; i++){
    pthread_create(&threads[i],NULL,function,(txns+i));
    // function(temp);
    // temp++;
  }

  for(int i=0;i<THREADS; i++){
    pthread_join(threads[i],NULL);
  }

  // printf("%f\n",(accounts+txns->ac1-1001)->bal);

  Temp=accounts;
  for(int i=0; i<10; i++){
    printf("%d %f",Temp->acc_no,Temp->bal);
    Temp++;
  }











  free(accounts);
  free(txns);
}
