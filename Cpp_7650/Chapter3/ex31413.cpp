//
//  ex31413.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION

void multiply(double** const mx, const double* const vr, int n, double* const pt) {
    for(int i = 0; i < n; i++){ // find the product
        pt[i] = 0;
        for (int j = i; j < n; j++) pt[i] += mx[i] [j]*vr[j];
    }
}


int main(int argc, const char * argv[]){
    int n = 4;
    double** const utm = new double*[n]; // create space for matrix
    for (int i =0; i < n; i++) utm[i] = new double[n]; // new double[n](); fill with zeros
    
    for (int i = 0; i < n; i++) // assign values to matrix
        for (int j = i; j < n; j++) utm[i][j] = 2*i + j;
    
    double* b = new double[n]; // create space for vector
    for (int j = 0; j < n; j++) b[j] = 3*j + 5;
    
    double* c = new double[n];
    multiply(utm, b, n, c); // matrix-vector multiply
     
    
    
    // Printing the matrix and solution details
    for (int i = 0; i < n; i++){ // assign values to matrix
        for (int j = 0; j < n; j++){
            double val = utm[i][j] > 1.e-27 ? utm[i][j] : 0;
            std::cout << " " << val  << " ";
        }
        std::cout <<  " | " << b[i]  <<  std::endl;
    }
    
    std::cout << "\nsolution = \n";
    for (int i = 0; i < n; i++){
        std::cout << "          " << c[i] << std::endl;
    }
    
    
    for (int i = 0; i < n; i++) delete[] utm[i] ;
    delete[] utm; delete[] b; delete []c;
    
    return 0;
}
#endif
