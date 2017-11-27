#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define MAXSIZE 4

int main (int argc, char** argv){
    int myid, numprocs;
    int i,isend,irecv;
    
    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    
    isend = myid+1;
    
    MPI_Scan(&isend,&irecv,1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
    
    printf("myid = %d  irecv = %d \n", myid, irecv);
    
    MPI_Finalize();
    
    return 0;
}
#endif
