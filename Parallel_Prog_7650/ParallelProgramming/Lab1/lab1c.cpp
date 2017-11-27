#include "mpi.h"
#include <stdio.h>
#include <math.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

int main(int argc, char **argv){
    int  myid, numprocs, namelen;
    int  loop;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    MPI_Get_processor_name(processor_name,&namelen);
    
    if (myid == 0) {
        int recval, mysum, newval;
        MPI_Status status;
        FILE *fp;
        char filename[255];
        
        printf("Node 0 is processor %s\n", &processor_name);
        printf("Number of processors is %d\n",  numprocs);
        
        sprintf(filename,"data/datafile%d.txt",myid);
        mysum = 0;
        if ((fp = fopen(filename,"r")) == NULL) { MPI_Abort(MPI_COMM_WORLD, 1); }
        
        while ((fscanf(fp,"%d", &newval)) != EOF) { mysum += newval; }
        fclose(fp);
        printf("Sum calculated by node 0 = %d\n", mysum);
        
        for(loop=0; loop<(numprocs-1); loop++) {
            MPI_Recv(&recval, 1, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &status);
            printf("Partial sum received from node %d = %d\n", status.MPI_SOURCE, recval);
            mysum += recval;
        }
        
        printf("Total sum = %d\n", mysum);
    }
    else {
        MPI_Status status;
        int mysum, newval, count;
        FILE *fp;
        char filename[255];
        
        sprintf(filename,"data/datafile%d.txt",myid);
        mysum = 0;
        if ((fp = fopen(filename,"r")) == NULL) { MPI_Abort(MPI_COMM_WORLD, 1); }
        
        count = 0;
        while ((fscanf(fp,"%d", &newval)) != EOF) {
            mysum += newval;
            count ++;
        }
        fclose(fp);
        
        printf("Node %d: Summed %d values.\n", myid, count);
        MPI_Send(&mysum, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
    }
    
    MPI_Finalize();
    
    return 0;
}
#endif
