/* Simple MPI program to demonstrate message broadcasting. */

/* Load information on functions used. */
//#include <mpi.h>
//#include <stdio.h>
//#include <math.h>
//#include <stdlib.h>
//
///* Single mainline code. */
//int main(int argc, char **argv)
//{
//    int  myid, numprocs;
//    
//    /* Pass command-line parameters to the MPI initialization routine */
//    /* to handle any MPI specific options and prepare the MPI system. */
//    MPI_Init(&argc, &argv);
//    
//    /* Determine the number of processes within our parallel system. */
//    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
//    
//    /* Determine the node number (rank) of this process. */
//    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
//    
//    /* Node 0 code block. */
//    if (myid == 0)
//    {
//        /* Define variable which are local to Node 0 only. */
//        int numvals, loop;
//        MPI_Status status;
//        FILE *fp;
//        char filename[255];
//        
//        /* As the user now many numbers each process should generate. */
//        printf("Enter number of random number each process is to generate: ");
//        scanf("%d", &numvals);
//        
//        /* Send this information to all the other processes using an MPI */
//        /* broadcast message. */
//        MPI_Bcast(&numvals, 1, MPI_INT, myid, MPI_COMM_WORLD);
//        
//        /* Build a unique file name for our data file. */
//        sprintf(filename,"data/datafile.%d",myid);
//        /* Open the file for writing. */
//        if ((fp = fopen(filename, "w")) == NULL)
//        { MPI_Abort(MPI_COMM_WORLD, 1); }
//        
//        /* Seed the random number generator. */
//        srand(myid+numprocs);
//        for(loop=0; loop<numvals; loop++)
//        {
//            /* Produce the random numbers and write them to the file. */
//            fprintf(fp,"%d\n",rand());
//        }
//        /* Done. Close the file. */
//        fclose(fp);
//    }
//    else
//    /* Code block for nodes other than Node 0. */
//    {
//        /* Define variables local to our process */
//        MPI_Status status;
//        int  numvals, loop;
//        FILE *fp;
//        char filename[255];
//        
//        /* Listen for a broadcast message from Node 0 telling us how many */
//        /* random numbers we are to produce for our data file. */
//        MPI_Bcast(&numvals, 1, MPI_INT, 0, MPI_COMM_WORLD);
//        
//        /* Build a unique file name for our data file. */
//        sprintf(filename,"data/datafile.%d",myid);
//        if ((fp = fopen(filename, "w")) == NULL)
//        { MPI_Abort(MPI_COMM_WORLD, 1); }
//        
//        /* Seed the random number generator. */
//        srand(myid+numprocs);
//        for(loop=0; loop<numvals; loop++)
//        {
//            /* Produce the random numbers and write them to the file. */
//            fprintf(fp,"%d\n",rand());
//        }
//        /* Close out the data file. */
//        fclose(fp);
//    }
//    
//    /* Clean up the MPI environment in preparation for program completion. */
//    MPI_Finalize();
//    
//    return 0;
//}
