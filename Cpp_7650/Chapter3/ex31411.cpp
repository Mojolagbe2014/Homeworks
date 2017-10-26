//
//  ex31411.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION

//multiply(const double** const mx, const double* const vr, int n, int m, double* const pt)
// will work for 2-D array not dynamic memory whose value needs to be changed
void multiply(double** const mx, const double* const vr, int n, int m, double* const pt) {
    for(int i = 0; i < n; i++){ // find the product
        pt[i] = 0;
        for (int j = 0; j < m; j++) pt[i] += mx[i] [j]*vr[j];
    }
}


int main(int argc, const char * argv[]){
    int n = 100, m = 200;
    double** const a = new double*[n]; // create space for matrix
    for (int i =0; i <n; i++) a[i] = new double[m];
    double* b = new double[m]; // create space for vector
    
    for (int i = 0; i < n; i++) // assign values to matrix
        for (int j = 0; j < m; j++) a[i][j] = i*i + j;
    
    for (int j = 0; j < m; j++) b[j] = 3*j + 5;

    double* c = new double[n];
    multiply(a, b, n, m, c); // matrix-vector multiply
    
    double sum = 0; // find sum of elements
    for (int i = 0; i < n; i++) sum += c[i];
    std::cout << sum << std::endl;
    
    
    for (int i = 0; i < n; i++) delete[] a[i] ;
    delete[] a; delete[] b; delete[] c;
    
    return 0;
}
#endif
