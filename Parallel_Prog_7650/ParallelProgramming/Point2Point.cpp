#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

int main (int argc, char** argv){
    int myid, numprocs;
    
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);

    int msgSize = 50;
    char msg[msgSize];
    
    if(myid == 0){
        //char msg[msgSize];
        MPI_Status status;
        
        for(unsigned i = 1; i < numprocs; i++){
            MPI_Recv(&msg, msgSize, MPI_CHAR, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, &status);
            printf("Received from Processor #%d:\n %s", status.MPI_SOURCE,msg);
        }
    }
    else {
        //char msg[msgSize];
        sprintf(msg, "Sent from Processor #%d\n", myid);
        MPI_Send(msg, msgSize, MPI_CHAR, 0, 0, MPI_COMM_WORLD);
    }
    
    MPI_Finalize();
    
    return 0;
}
#endif
