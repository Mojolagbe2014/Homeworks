#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

int main (int argc, char** argv){
    int x, myid, numprocs;
    
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    
    printf("Hello from id %d\n", myid);
    x=5;
    if(myid==0){
        int x=10;
    }
    printf("myID is %d x=%d \n",myid,x);
    
    MPI_Finalize();
    
    return 0;
}
#endif
