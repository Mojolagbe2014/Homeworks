#include "mpi.h"
#include <stdio.h>
#include <math.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

int main(int argc, char **argv) {
    int  myid, numprocs, namelen;
    int  loop;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    MPI_Get_processor_name(processor_name,&namelen);
    
    if (myid == 0) {
        int recval, mysum, newval, d, destination;
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
        
        for(d=3; d>0; d--) {
            if (myid < (1 << d)) {
                if (myid & (1 << (d-1))) {
                    destination = (myid-(1<<(d-1)));
                    printf("(%d) Send %d ---> %d\n", d, myid, destination);
                    MPI_Send(&mysum, 1, MPI_INT, destination, d, MPI_COMM_WORLD);
                }
                else  {
                    MPI_Recv(&recval, 1, MPI_INT, (myid+(1<<(d-1))), d, MPI_COMM_WORLD, &status);
                    mysum += recval;
                    printf("Node %d: (%d) My sum now = %d\n", myid, d, mysum);
                }
            }
        }
        
        printf("Total sum = %d\n", mysum);
    }
    else {
        MPI_Status status;
        int recval, mysum, newval, count, d, destination;
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
        
        for(d=3; d>0; d--) {
            if (myid < (1 << d)) {
                if (myid & (1 << (d-1))) {
                    destination = (myid-(1<<(d-1)));
                    printf("(%d) Send %d ---> %d\n", d, myid, destination);
                    MPI_Send(&mysum, 1, MPI_INT, destination, d, MPI_COMM_WORLD);
                }
                else {
                    MPI_Recv(&recval, 1, MPI_INT, (myid+(1<<(d-1))), d, MPI_COMM_WORLD, &status);
                    mysum += recval;
                    printf("Node %d: (%d) My sum now = %d\n", myid, d, mysum);
                }
            }
        }
    }
    
    MPI_Finalize();
    
    return 0;
}
#endif
