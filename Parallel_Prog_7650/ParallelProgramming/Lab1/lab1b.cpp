/* Simple MPI program to demonstrate message broadcasting. */

/* Load information on functions used. */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
//#define RUN_SECTION

#ifdef RUN_SECTION
#include <mpi.h>

int main(int argc, char **argv) {
    int  myid, numprocs;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);

    if (myid == 0)  {
        int numvals, loop;
        MPI_Status status;
        FILE *fp;
        char filename[255];

        //printf("Enter number of random number each process is to generate: ");
        //scanf("%d", &numvals);
        numvals=2;

        /* Send this information to all the other processes using an MPI */
        /* broadcast message. */
        MPI_Bcast(&numvals, 1, MPI_INT, myid, MPI_COMM_WORLD);

        sprintf(filename,"data/datafile%d.txt", myid);
        if ((fp = fopen(filename, "w")) == NULL) { MPI_Abort(MPI_COMM_WORLD, 1); }

        srand(myid+numprocs);
        for(loop=0; loop<numvals; loop++) { fprintf(fp,"%d\n",rand()); }
        fclose(fp);
    }
    else {
        MPI_Status status;
        int  numvals, loop;
        FILE *fp;
        char filename[255];
        
        /* Listen for a broadcast message from Node 0 telling us how many */
        /* random numbers we are to produce for our data file. */
        MPI_Bcast(&numvals, 1, MPI_INT, 0, MPI_COMM_WORLD);
        
        sprintf(filename,"data/datafile%d.txt",myid);
        if ((fp = fopen(filename, "w")) == NULL) { MPI_Abort(MPI_COMM_WORLD, 1); }
        
        srand(myid+numprocs);
        for(loop=0; loop<numvals; loop++) { fprintf(fp,"%d\n",rand()); }
        fclose(fp);
    }

    MPI_Finalize();
    
    return 0;
}
#endif
