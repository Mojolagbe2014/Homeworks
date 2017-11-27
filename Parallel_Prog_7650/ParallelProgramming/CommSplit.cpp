#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define NPROCS 4

int main (int argc, char** argv){
    int rank, newrank, newtasks, numtasks, sendbuf, recvbuf;
    int icolor,ikey;
    
    MPI_Comm newcomm;/* handle of the new communicator */
    
    MPI_Init(&argc,&argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
    
    if (numtasks != NPROCS) {
        printf("Must specify NPROCS= %d. Terminating.\n",NPROCS);
        MPI_Finalize();
        exit(0);
    }
    
    if(rank == 0){
        icolor=0;
        ikey=1;
    }
    else if (rank == 1) {
        icolor=0;
        ikey=0;
    }
    else if (rank == 2) {
        icolor=1;
        ikey=0;
    }
    else if (rank == 3) {
        icolor=1;
        ikey=1;
    }

    
    MPI_Comm_split(MPI_COMM_WORLD, icolor, ikey, &newcomm);
    MPI_Comm_rank(newcomm, &newrank);
    MPI_Comm_size(newcomm, &newtasks);
    
    //sendbuf = rank;
    //MPI_Allreduce(&sendbuf, &recvbuf, 1, MPI_INT, MPI_SUM, newcomm);
    ////MPI_Allreduce(&sendbuf, &recvbuf, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
    //printf("rank = %d  newrank = %d  recv = %d \n", rank, newrank, recvbuf);
    
    printf("rank = %d  newrank = %d  newtasks = %d \n", rank, newrank, newtasks);
    
    MPI_Finalize();
    
    return 0;
}
#endif
