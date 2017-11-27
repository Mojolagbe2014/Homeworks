#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define SIZE 4

int main (int argc, char** argv){
    int numtasks, rank, source=0, tag=1, i;
    float a[SIZE][SIZE] = {1.0, 2.0, 3.0, 4.0,   5.0, 6.0, 7.0, 8.0,   9.0, 10.0, 11.0, 12.0,   13.0, 14.0, 15.0, 16.0};
    float b[SIZE];
    
    MPI_Status stat;
    MPI_Datatype ROW_TYPE;
    
    MPI_Init(&argc,&argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
    
    MPI_Type_contiguous(SIZE, MPI_FLOAT, &ROW_TYPE);
    MPI_Type_commit(&ROW_TYPE);
    
    if (rank == 0)
        for (i=0; i<numtasks; i++)
            MPI_Send(&a[i][0], 1, ROW_TYPE, i, tag, MPI_COMM_WORLD);
    
    MPI_Recv(b, SIZE, MPI_FLOAT, source, tag, MPI_COMM_WORLD, &stat);
    //MPI_Recv(b, 1, ROW_TYPE, source, tag, MPI_COMM_WORLD, &stat);
    printf("rank = %d b = %3.1f %3.1f %3.1f %3.1f\n", rank,b[0],b[1],b[2],b[3]);
    
    MPI_Type_free(&ROW_TYPE);
    
    MPI_Finalize();
    
    return 0;
}
#endif
