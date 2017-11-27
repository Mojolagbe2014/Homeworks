#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define MAXSIZE 4

int main (int argc, char** argv){
    int myid, numprocs;
    int data[MAXSIZE], i, x, low, high, myresult, result;
    
    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    
    if (myid == 1)
        for(i = 0; i < MAXSIZE; i++) data[i]=i;
    else
        for(i = 0; i < MAXSIZE; i++) data[i]=0;
    
    
    printf("myid=%d : before \n ",myid);
    for(i=0; i < MAXSIZE; i++)
        printf("i=%d data[i]=%d \n",i,data[i]);
    
    MPI_Bcast(data, MAXSIZE, MPI_INT, 1, MPI_COMM_WORLD);
    
    printf("myid=%d : after \n ",myid);
    for(i=0; i < MAXSIZE; i++)
        printf("i=%d data[i]=%d \n",i,data[i]);
    
    MPI_Finalize();
    
    return 0;
}
#endif
