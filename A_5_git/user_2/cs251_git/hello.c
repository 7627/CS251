#include<stdio.h>
void microkernel_sendmsg(char *);
void main(){
    printf("Helloworld!\n");
    printf("This must be a monolithic design\n");
    microkernel_sendmsg("is more portable");
    printf("A change by user_2");
}
void microkernel_sendmsg(char *a){
    printf("microkernel: %s\n", a);
}

