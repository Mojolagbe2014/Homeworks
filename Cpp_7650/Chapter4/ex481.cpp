//
//  main.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-04.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <stdio.h>
#include <iostream>
#include <cmath>
//#define RUN_SECTION
#ifdef RUN_SECTION
namespace Vec {
    const int maxsize = 100000;
    double onenorm(const double* const, int); // 1-norm
    double twonorm(const double* const, int); // 2-norm
    double maxnorm(const double* const, int); // max norm
    
    void add(const double* const, const double* const, double*, int);  // vector addition
    void add(double* const, const double* const, int);  // vector addition
    void scale(const double* const, double, double*, int);             // vector-scalar multiplication
    void scale(double* const, double, int);                      // vector-scalar multiplication
    void product(const double* const, double*, int);
}

namespace Mat {
    double onenorm(const double** const, int);  // 1-norm
    double maxnorm(const double** const, int);  // max norm
    double frobnorm(const double** const, int); // Frobenius
    
    void add(double** const, double** const, int, int, double** const); // matrix addition
    void add(double** const, const double** const, int, int); // matrix addition
    void multiply(double** const, const double* const, int, int, double* const);           // matrix-vector multiplication
    
}


//===== VECTOR NAMESPACE DEFINITIONS ======//
double Vec::onenorm(const double* const v, int size){
    double sigma = 0.;
    for(unsigned i = 0; i < size; i++) sigma += std::abs(v[i]);
    
    return sigma;
}

double Vec::twonorm(const double* const v, int size){
    double sigma = 0.;
    for(unsigned i = 0; i < size; i++) sigma += std::pow(v[i], 2);
    
    return sqrt(sigma);
}

double Vec::maxnorm(const double* const v, int size){
    double max = -1.;
    for(unsigned i = 0; i < size; i++) max = max > std::abs(v[i]) ? max : std::abs(v[i]);
    
    return max;
}

void Vec::add(const double* const a, const double* const b, double* c, int size){
    for(unsigned i = 0; i < size; i++) c[i] = a[i] + b[i];
}

void Vec::add(double* const a, const double* const b, int size){
    for(unsigned i = 0; i < size; i++) a[i] += b[i];
}

void Vec::scale(const double* const a, double b, double* c, int size){ // vector-scalar product
    for(unsigned i = 0; i < size; i++) c[i] = a[i]*b;
}

void Vec::scale(double* const a, double b, int size){ // vector-scalar product
    for(unsigned i = 0; i < size; i++) a[i] *= b;
}



//======== MATRIX NAMESPACE DEFINITIONS ====//
double Mat::onenorm(const double** const A, int dim){
    double* temp = new double[dim];
    for(unsigned j = 0; j < dim; j++){//column wise
        double sigma = 0.;
        for(unsigned i = 0; i < dim; i++) sigma += std::abs(A[i][j]);
        temp[j] = sigma;
    }
    
    double max = -1.;
    for(unsigned i = 0; i < dim; i++) max = max > std::abs(temp[i]) ? max : std::abs(temp[i]);
    
    delete[] temp;
    return max;
}

//double Mat::maxnorm(const double** const A, int dim){
//    double max = -1.;
//    for(unsigned i = 0; i < dim; i++){//row wise
//        double sigma = 0.;
//        for(unsigned j = 0; j < dim; j++) sigma += std::abs(A[i][j]);
//        
//        max = std::max(max, sigma);
//    }
//    return max;
//}

double Mat::maxnorm(const double** const A, int dim){
    double maxnorm = -1.;
    for(unsigned i = 0; i < dim; i++){//row wise
        maxnorm = std::max(maxnorm, Vec::onenorm(A[i], dim));
    }
    return maxnorm;
}

double Mat::frobnorm(const double** const A, int dim){
    double sigma = 0.;
    for(unsigned i = 0; i < dim; i++)
        for(unsigned j = 0; j < dim; j++)
            sigma += std::pow(A[i][j], 2);
    
    
    return sqrt(sigma);
}

void Mat::multiply(double** const A, const double* const v, int n, int m, double* const result) {
    double* temp = new double[m];
    for(int i = 0; i < n; i++){ // find the product
        result[i] = 0;
        for (int j = 0; j < m; j++) result[i] += A[i][j]*v[j];
    }
}

void Mat::add(double** const a, double** const b, int n, int m, double** const c){
    for(unsigned i = 0; i < n; i++)
        for(unsigned j = 0; j < m; j++)
            c[i][j] = a[i][j] + b[i][j];
        
}

void Mat::add(double** const a, const double** const b, int n, int m){
    for(unsigned i = 0; i < n; i++)
        for(unsigned j = 0; j < m; j++)
            a[i][j] += b[i][j];
}


int main (){
    const int n = 3, m = 3;
    double v[] = {1,-2,0,10};
    double B[n][m] = {{1, -2, 0}, {-4, 3, 5}, {2, 0, 6}};
    
    const double **A = new const double*[n];
    for(unsigned i = 0; i < n; i++) A[i] = B[i];
    
    
    std::cout << "\n********************* VECTOR ********************\n";
    std::cout << "1-Norm   = " << Vec::onenorm(v, 4) << std::endl;
    std::cout << "2-Norm   = " << Vec::twonorm(v, 4) << std::endl;
    std::cout << "Inf-Norm = " << Vec::maxnorm(v, 4) << std::endl;
    
    std::cout << "\n********************* MATRIX ********************\n";
    std::cout << "1-Norm   = " << Mat::onenorm(A, 3) << std::endl;
    std::cout << "Inf-Norm = " << Mat::maxnorm(A, 3) << std::endl;
    std::cout << "Fro-Norm = " << Mat::frobnorm(A, 3) << std::endl;
    
    
    std::cout << "\n********************* MATRIX - VECTOR OPERATIONS ********************\n";
    int N = 10, M = 10;
    double** const a = new double*[N];              // create space for matrix
    for (int i =0; i <N; i++) a[i] = new double[M];
    
    for (int i = 0; i < N; i++)                     // assign values to matrix a
        for (int j = 0; j < M; j++) a[i][j] = cos(i*i + j);
    
    double* x = new double[M];                      // create space for vector x
    for (int i = 0; i < M; i++) x[i] = sin(i);      // assign value to x[i]
    
    double* b = new double[M]();                      // allocate space for result : ax = b
    
    
    Mat::multiply(a, x, N, M, b); // matrix-vector multiply
    
    // Printing the matrix and solution details
    for (int i = 0; i < N; i++){ // assign values to matrix
        for (int j = 0; j < M; j++){
            std::cout.precision(2);
            std::cout << " " << a[i][j]  << " ";
        }
        std::cout <<  " | " << x[i]  <<  std::endl;
    }
    
    std::cout << "\nsol = \n";
    for (int i = 0; i < N; i++){
        std::cout << "          " << b[i] << std::endl;
    }
    
    // === test section ===//
    double** const aa = new double*[N];              // create space for matrix
    for (int i =0; i <N; i++) aa[i] = new double[M];
    
    Mat::add(a, a, N, M, aa);
    
    std::cout << "\A + A = \n";
    for (int i = 0; i < N; i++){ // assign values to matrix
        for (int j = 0; j < M; j++){
            std::cout.precision(2);
            std::cout << " " << aa[i][j]  << " ";
        }
        std::cout <<  std::endl;
    }
    

    double* test1 = new double[M]();
    Vec::add(b, b, test1, M);
    std::cout << "\nsol + sol = \n";
    for (int i = 0; i < N; i++){
        std::cout << "          " << test1[i] << std::endl;
    }
    
    double* test2 = new double[M]();
    Vec::scale(b, 3.0, test2, M);
    std::cout << "\n3*sol = \n";
    for (int i = 0; i < N; i++){
        std::cout << "          " << test2[i] << std::endl;
    }

    for (int i = 0; i < N; i++) {delete[] a[i]; delete[] aa[i];}
    delete[] a; delete[] aa; delete[] A; delete[] b; delete[] x;  delete[] test1;  delete[] test2;
    
    return 0;
}
#endif


