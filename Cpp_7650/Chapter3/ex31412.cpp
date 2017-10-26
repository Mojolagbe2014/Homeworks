//
//  ex31412.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION

int main(int argc, const char * argv[]){
    int n = 4;
    double** const utm = new double*[n]; // create space for matrix
    for (int i =0; i < n; i++) utm[i] = new double[n]; // new double[n](); fill with zeros
    
    for (int i = 0; i < n; i++) // assign values to matrix
        for (int j = i; j < n; j++) utm[i][j] = 2*i + j;
    
    for (int i = 0; i < n; i++){ // assign values to matrix
        for (int j = 0; j < n; j++){
            std::cout << " " << (int)utm[i][j]  << " ";
        }
        std::cout << std::endl;
    }
    
    
    for (int i = 0; i < n; i++) delete[] utm[i] ;
    delete[] utm;
    
    return 0;
}
#endif
