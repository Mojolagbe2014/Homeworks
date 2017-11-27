#include <stdio.h>
#include <mpi.h>
//#define RUN_SECTION
#ifdef RUN_SECTION

#define NELEM 25

typedef struct {
    float x, y, z;
    float velocity;
    int n, type;
} Particle;

int main (int argc, char** argv){
    int numtasks, rank, source=0, tag=1, i;
    Particle p[NELEM], particles[NELEM];
    
    MPI_Datatype   PARTICLE_TYPE, oldtypes[2];
    int blockcounts[2];
    
    /* MPI_Aint type used to be consistent with syntax of */
    /* MPI_Type_extent routine */
    MPI_Aint offsets[2], extent;
    MPI_Status stat;
    
    MPI_Init(&argc,&argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
    
    /* Setup description of the four MPI_FLOAT fields: x, y, z, velocity */
    offsets[0] = 0;
    oldtypes[0] = MPI_FLOAT;
    blockcounts[0] = 4;
    
    /* Setup description of the two MPI_INT fields: n, type */
    /* Need to first figure offset by getting size of MPI_FLOAT */
    MPI_Type_extent(MPI_FLOAT, &extent);
    offsets[1] = 4 * extent;
    oldtypes[1] = MPI_INT;
    blockcounts[1] = 2;
    
    /* Now define structured type and commit it */
    MPI_Type_struct(2, blockcounts, offsets, oldtypes, &PARTICLE_TYPE);
    MPI_Type_commit(&PARTICLE_TYPE);
    
    /* Initialize the particle array and then send it to each task */
    if (rank == 0) {
        for (i=0; i<NELEM; i++) {
            particles[i].x = i * 1.0;
            particles[i].y = i * -1.0;
            particles[i].z = i * 1.0;
            particles[i].velocity = 0.25;
            particles[i].n = i;
            particles[i].type = i % 2;
        }
        
        for (i=0; i<numtasks; i++)
            MPI_Send(particles, NELEM, PARTICLE_TYPE, i, tag, MPI_COMM_WORLD);
    }
    
    MPI_Recv(p, NELEM, PARTICLE_TYPE, source, tag, MPI_COMM_WORLD, &stat);
    
    /* Print a sample of what was received */
    printf("rank = %d %3.2f %3.2f %3.2f %3.2f %d %d\n", rank,p[3].x, p[3].y,p[3].z,p[3].velocity,p[3].n,p[3].type);
    
    MPI_Type_free(&PARTICLE_TYPE);

                  
    MPI_Finalize();
    
    return 0;
}
#endif
