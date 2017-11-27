#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define NPROCS 4

int main (int argc, char** argv){
    int rank, new_rank, sendbuf, recvbuf, numtasks;
    int ranks1[2]={0,1}, ranks2[2]={2,3};
    
    MPI_Group orig_group, new_group;  /* declaration of groups to create */
    MPI_Comm new_comm;/* declaring the new communicator */
    
    MPI_Init(&argc,&argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
    
    if (numtasks != NPROCS) {
        printf("Must specify NPROCS= %d. Terminating.\n",NPROCS);
        MPI_Finalize();
        exit(0);
    }
    
    sendbuf = rank;
    /* Extract the original group handle */
    MPI_Comm_group(MPI_COMM_WORLD, &orig_group);
    
    /* Divide tasks into two distinct groups based upon rank */
    if (rank < NPROCS/2)
        MPI_Group_incl(orig_group, NPROCS/2, ranks1, &new_group);
    else
        MPI_Group_incl(orig_group, NPROCS/2, ranks2, &new_group);
    
    
    /* MPI_Group_incl creates a new group of tasks from an existing group     */
    /* Syntax: MPI_Group_incl(MPI_Group oldgroup, int n, int *ranks, MPI_Group *newgroup)          */
    /* oldgroup is the original group (handle) (IN) */
    /* n is number of elements in array ranks and the size of newgroup (IN) */
    /* ranks is ranks of tasks in group to appear in newgroup (array of int) (IN) */
    /* newgroup is new group derived from oldgroup in order defined */
    /* by ranks (handle) (OUT)*/
    
    /* Create new communicator and then perform collective communications */
    MPI_Comm_create(MPI_COMM_WORLD, new_group, &new_comm);
    MPI_Allreduce(&sendbuf, &recvbuf, 1, MPI_INT, MPI_SUM, new_comm);
    //MPI_Allreduce(&sendbuf, &recvbuf, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD); Intercommunicator access
    MPI_Group_rank (new_group, &new_rank);
    //MPI_Comm_rank(new_comm, &new_rank);
    
    printf("rank = %d newrank = %d recvbuf = %d\n",rank,new_rank,recvbuf);
                  
    MPI_Finalize();
    
    return 0;
}
#endif
/* MPI_Comm_create creates a new communicator with a given group */
/* Syntax: MPI_Comm_create(MPI_Comm comm_in, MPI_Group group, MPI_Comm *comm_out)          */
/* comm_in is the original communicator (handle) (IN) */
/* group is a group of tasks that will be in the new communicator (handle) (IN) */
/* comm_out is the new communicator (handle) (OUT) */
