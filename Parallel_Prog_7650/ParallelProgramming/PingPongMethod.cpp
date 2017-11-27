//
//  pingPongMethod.cpp
//  ParallelProgramming
//
//  Created by Mojolagbe Mojolagbe on 2017-10-02.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//
// This program basically tests MESSAGE LATENCY (startup time) - time to send zero length message

#include <stdio.h>
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>
//#define RUN_SECTION
#ifdef RUN_SECTION
#define NUMBER_REPS 4

int main(int argc,char **argv){
    int reps = NUMBER_REPS, /* number of samples per test */
    tag,                    /* MPI message tag parameter */
    numtasks,               /* number of MPI tasks */
    rank,                   /* my MPI task number */
    dest, source,           /* send/receive task designators */
    avgT,                   /* average time per rep in microseconds */
    rc,                     /* return code */
    n;
    double T1, T2,          /* start/end times per rep */
    sumT,                   /* sum of all reps times */
    deltaT;                 /* time for one rep */
    char msg;               /* buffer containing 1 byte message */
    MPI_Status status;      /* MPI receive routine parameter */
    
    MPI_Init(&argc,&argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
    
    if(rank == 0) {
        /* round-trip latency timing test */
        printf("task %d has started...\n", rank);
        printf("Beginning latency timing test. Number of reps = %d.\n", reps);
        printf("Rep#       T1               T2            deltaT\n");
        dest = 1; source = 1;
        
        for (n = 1; n <= reps; n++) {
            T1 = MPI_Wtime();/* start time */
            
            /* send message to worker -message tag set to 1.  */
            rc = MPI_Send(&msg, 1, MPI_BYTE, dest, tag, MPI_COMM_WORLD);
            
            /* Now wait to receive the echo reply from the worker  */
            rc = MPI_Recv(&msg, 1, MPI_BYTE, source, tag, MPI_COMM_WORLD,&status);
            
            T2 = MPI_Wtime();       /* end time */
            
            /* calculate round trip time and print */
            deltaT = T2 -T1;
            printf("%4d  %8.8f  %8.8f  %2.8f\n", n, T1, T2, deltaT);
            sumT += deltaT;
        }
        avgT = (sumT*1000000)/reps;
        
        printf("\n Avg round trip time = %d microseconds\n", avgT);
        printf("Avg oneway latency = %d microseconds\n", avgT/2);
    }
    else if(rank == 1){
        printf("task %d has started...\n", rank);
        dest = 0; source = 0;
        
        for (n = 1; n <= reps; n++) {
            rc = MPI_Recv(&msg, 1, MPI_BYTE, source, tag, MPI_COMM_WORLD,&status);
            rc = MPI_Send(&msg, 1, MPI_BYTE, dest, tag, MPI_COMM_WORLD);
        }
    }
    
    MPI_Finalize();
    
    return 0;
}
#endif
