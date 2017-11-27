#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define MAXSIZE 4

int main (int argc, char** argv){
    int myid, numprocs;
    int data[MAXSIZE], i,myresult, result;
    
    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    
    if (myid == 0)
        for(i = 0; i < MAXSIZE; i++)
            data[i] = i;
    
    //MPI_Bcast(data, MAXSIZE, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Scatter(&data, 1, MPI_INT, &myresult, 1, MPI_INT, 0, MPI_COMM_WORLD);
    
    //myresult = 0;
    //for(i = 0; i < MAXSIZE; i++)  myresult += data[i];
    
    printf("I got %d from %d\n", myresult, myid);
    
    MPI_Reduce(&myresult, &result, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
    
    if (myid == 0)
        printf("The sum is %d.\n", result);
    
    MPI_Finalize();
    
    return 0;
}
#endif
