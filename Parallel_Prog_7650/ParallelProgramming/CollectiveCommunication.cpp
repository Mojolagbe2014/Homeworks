//
//  CollectiveCommunication.cpp
//  ParallelProgramming
//
//  Created by Mojolagbe Mojolagbe on 2017-09-25.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

//#include <stdio.h>
//#include <math.h>
//#include <mpi.h>
//#include <iostream>
//
//#define MAXSIZE 1000
//
//int main (int argc, char** argv){
//    
//    int myid, numprocs;
//    int data[MAXSIZE], i, x, low, high, myresult, result;
//    char fn[255];
//    FILE *fp;
//    
//    MPI_Init(&argc, &argv);
//    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
//    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
//    
//    if(myid == 0){
//        strcpy(fn, std::getenv("HOME"));
//        strcat(fn, "/MPI/rand_data.txt");
//        
//        fp = fopen(fn, "w");
//        
//        if(fp == NULL){
//            printf("Can't open the input file: %s\n\n", fn);
//            exit(1);
//        }
//        
//        for(i = 0; i < MAXSIZE; i++) fscanf(fp, "%d", &data[i]);
//    }
//    
//    //broadcast data
//    MPI_Bcast(data, MAXSIZE, MPI_INT, 0, MPI_COMM_WORLD);
//    
//    //Add my portion of data
//    x = MAXSIZE / numprocs;             // must be an integer
//    low = myid * x;
//    high = low + x;
//    myresult = 0;
//    
//    for(i= low; i<high; i++) myresult += data[i];
//    printf("I got %d from %d\n", myresult, myid);
//    
//    //compute global sum
//    MPI_Reduce(&myresult, &result, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
//    
//    if(myid == 0)   printf("The sum is %d.\n", result);
//
//    MPI_Finalize();
//    
//    return 0;
//}

