#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <math.h>
#include <time.h>
#define RUN_SECTION
#ifdef RUN_SECTION

int main (int argc, char** argv){
    int myid,numprocs;
    const int tag=42;
    int i,j,err;
    int *data;
    int msg,x = 0, number, nsort;
    
    MPI_Status status;
    int namelen;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    
    nsort=numprocs;
    
    if(myid== 0){ /* process 0 is the head node of the pipeline *//* Generate random numbers */
        int temp;
        int rcvd_msg_size;
        int *msg_rcvd;
        
        srand(clock());
        data = new int[nsort];
        
        for(i=0; i<nsort; i++){
            data[i]=rand();
        };
        
        for(i=0; i<nsort; i++)
            printf("%d-th unsorted element is %d \n",i,data[i]);
        
        x = data[0];
        for (i=1; i<nsort; i++) {
            msg=data[i];
            if(msg> x){
                temp=x;
                x=msg;
                msg=temp;
            }
            err=MPI_Send(&msg,1,MPI_INT,1,tag,MPI_COMM_WORLD);/*injecting #s into pipe*/
        }
        
        MPI_Get_processor_name(processor_name,&namelen);
        printf("myid= %d  mynameis %s my_x= %d \n",myid,processor_name,x);
        printf("0-th sorted element is %d \n",x);
        
        rcvd_msg_size = nsort-1;
        msg_rcvd = new int [rcvd_msg_size*sizeof(int)]; /*allocating space for sorted #s*/
        /* receiving sorted numbers */
        MPI_Recv(msg_rcvd,rcvd_msg_size,MPI_INT,1,tag,MPI_COMM_WORLD,&status);
        
        for(i=0; i<nsort-1; i++)
            printf("%d-th sorted element is %d \n",i+1,msg_rcvd[nsort-i-2]);free(msg_rcvd);
    }/* if(myid== 0) */

    
    else {/* if(myid!= 0) */
        for (i=1; i<nsort; i++){
            for(j=1; j<i; j++){
                if(myid== j){
                    int temp;
                    MPI_Recv(&msg,1,MPI_INT,myid-1,tag,MPI_COMM_WORLD,&status);
                    
                    if(msg> x){
                        temp=x;
                        x=msg;
                        msg=temp;
                    }
                    MPI_Send(&msg,1,MPI_INT,myid+1,tag,MPI_COMM_WORLD);
                }
            }
            
            if(myid== i){
                MPI_Recv(&msg,1,MPI_INT,myid-1,tag,MPI_COMM_WORLD,&status);
                x=msg;
            }
        }
        
        MPI_Get_processor_name(processor_name,&namelen);
        printf("myid= %d  mynameis %s my_x= %d \n",myid,processor_name,x);
        
        /*Returning the numbers */
        if(myid== nsort-1)
            MPI_Send(&x,1,MPI_INT,myid-1,tag,MPI_COMM_WORLD);
        
        if(myid!= nsort-1 && myid!= 0){
            int*msg_rcvd;
            int*msg_sent;
            int rcvd_msg_size;
            int sent_msg_size;
            
            rcvd_msg_size = nsort-myid-1;
            sent_msg_size = rcvd_msg_size+1;
            msg_rcvd = new int [rcvd_msg_size*sizeof(int)];
            
            MPI_Recv(msg_rcvd,rcvd_msg_size,MPI_INT, myid+1,tag,MPI_COMM_WORLD,&status);
            msg_sent = new int [sent_msg_size*sizeof(int)];
            
            for(j=0; j<rcvd_msg_size; j++)
                msg_sent[j]=msg_rcvd[j];
            
            msg_sent[sent_msg_size-1]=x;free(msg_rcvd);
            
            MPI_Send(msg_sent,sent_msg_size,MPI_INT, myid-1,tag,MPI_COMM_WORLD);free(msg_sent); }
    }

    MPI_Finalize();
    
    return 0;
}
#endif
