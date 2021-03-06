//
//  BlockDistribution.cpp
//  ParallelProgramming
//
//  Created by Mojolagbe Mojolagbe on 2017-10-05.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <stdio.h>
#include <math.h>
#include <mpi.h>
#include <iostream>
//#define RUN_SECTION

#ifdef RUN_SECTION

void para_range(int, int, int, int, int*, int* );
void paraRange(int start, int end, int nProcs, int myRank, int *myStart, int *myEnd);

int main (int argc, char** argv){
    const unsigned N = 9;
    int myid, numprocs, ista, myStart, iend, myEnd;
    
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    
    para_range(0, N-1, numprocs, myid, &ista, &iend);
    paraRange(0, N-1, numprocs, myid, &myStart, &myEnd);
    //for(int i = ista; i <= iend; i++){}
    
    std::cout << "Process " << myid << " ==> " << ista << " to " << iend << std::endl;
    std::cout << "Pro " << myid << " ==> " << myStart << " to " << myEnd << "\n\n";
//    
//    if(myid == 0){
//        FILE *fp;
//        if ((fp = fopen("data/test.txt", "w")) == NULL) { MPI_Abort(MPI_COMM_WORLD, 1); }
//        fprintf(fp,"%d\n",123);
//        fclose(fp);
//    }
    
    MPI_Finalize();

    return 0;
}




void para_range(int n1, int n2, int nprocs, int irank, int *ista, int* iend){
    /* n1=0,n2=9,nprocs=4 */
    int iwork1, iwork2;
    int min;
    iwork1 = (n2 - n1 + 1) / nprocs;                /* iwork1=2 */
    iwork2 = (n2 - n1 + 1) % nprocs;                /* iwork2=2 */
                                                    /* irank= 0,1,2,3 */
    min = (irank < iwork2 ? irank : iwork2);        /* min=  0,1,2,2 */
    *ista = irank * iwork1 + n1 + min;              /* ista=   0,3,6,8 */
    *iend = *ista + iwork1 - 1;                     /* iend=  1,4,7,9 */
    if(iwork2 > irank) *iend += 1;                  /* iend=  2,5,7,9 */
}

void paraRange(int start, int end, int nProcs, int myRank, int *myStart, int *myEnd){
    int p = nProcs;                     // divisor
    int q = (end - start + 1) / p;      // quotient (+1 fixes 0 indexing)
    int r = (end - start + 1) % p;      // remainder (+1 fixes 0 indexing)
    
    int min = std::min(myRank, r);
    *myStart = myRank*q + min + start;
    *myEnd = *myStart + q - 1;          // (-1 fixes 0 indexing)
    
    if(r > myRank) *myEnd += 1;
}

#endif
