#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define SIZE 4

int main (int argc, char** argv){
    int myid, numprocs;
    int i, isend, irecv[SIZE];
    
    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    
    isend = myid+1;
    
    MPI_Gather(&isend,1,MPI_INT, irecv,1, MPI_INT,0,MPI_COMM_WORLD);
    //MPI_Allgather(&isend,1,MPI_INT, irecv,1, MPI_INT,MPI_COMM_WORLD);
    
    if(myid == 0)
        printf("recv = [%d, %d, %d, %d] \n",irecv[0],irecv[1],irecv[2], irecv[3]);
    
    MPI_Finalize();
    
    return 0;
}
#endif
