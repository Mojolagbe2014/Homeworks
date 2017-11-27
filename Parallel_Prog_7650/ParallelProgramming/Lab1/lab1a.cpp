/* Simple MPI program to demonstrate basic message passing between nodes. */

/* Load information on functions used. */

#include <stdio.h>
#include <math.h>
//#define RUN_SECTION
#ifdef RUN_SECTION
#include "mpi.h"

int main(int argc, char **argv) {
    int  myid, numprocs, namelen;
    int  loop;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    
    MPI_Get_processor_name(processor_name,&namelen);
    
    if (myid == 0) {
        int recval;
        MPI_Status status;
        char host[MPI_MAX_PROCESSOR_NAME];
        
        printf("Node 0 is processor %s\n", &processor_name);
        printf("Number of processors is %d\n",  numprocs);
        
        for(loop=0; loop<(numprocs-1); loop++) {
            MPI_Recv(&host, MPI_MAX_PROCESSOR_NAME, MPI_CHAR, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);
            printf("Message received from node %d on host %s\n", status.MPI_SOURCE, host);
        }
    }
    else {
        //MPI_Status status;
        MPI_Send(processor_name, MPI_MAX_PROCESSOR_NAME, MPI_CHAR, 0, 0, MPI_COMM_WORLD);
    }
    
    
    MPI_Finalize();
    
    return 0;
}
#endif
