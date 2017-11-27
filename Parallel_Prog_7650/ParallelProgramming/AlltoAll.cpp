#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define SIZE 4

int main (int argc, char** argv){
    int myid, numprocs;
    int i,isend[SIZE],irecv[SIZE];
    
    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    
    for(i=0; i<numprocs; i++)
        isend[i] = (i+1) + numprocs*myid;
    
    MPI_Alltoall(isend,1,MPI_INT, irecv,1, MPI_INT,MPI_COMM_WORLD);
    
    printf("myid = %d isend = %d  %d  %d  %d \n", myid, isend[0],isend[1],isend[2],isend[3]);
    printf("myid = %d irecv = %d  %d  %d  %d \n", myid, irecv[0],irecv[1],irecv[2],irecv[3]);
    
    MPI_Finalize();
    
    return 0;
}
#endif
