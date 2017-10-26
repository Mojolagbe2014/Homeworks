//
//  ex31410.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION

int main(int argc, const char * argv[]){
    /* 
     STORAGE POINT OF VIEW
     1. Content of a 2-dimensional array are stored on the stack while the content of a double-pointer are stored in the heap.
     2. Access to data stored in 2-D array is faster than that of double-pointer conterpart
     3. Size of 2-D array must be known before hand - that is, it has stack memory allocation, while while double-pointer array can be allocated both statically and dynamically.
     
     ADDRESSING POINT OF VIEW WITH 1-D ARRAY
     1. The rule of thumb states that an N-Dimensional array allocated statically will decay into a point such that the base address of &tda[0][0], &tda[0], tda[0] and tda are the same; While a double-point is basically a pointer to array of pointers, meaning that, the base address of &dpa[0] and dpa are the same since they are pointing to the same address, however &dpa[0][0] and dpa[0] are the same which is basically the address of column [0] of the double pointer array. The behaviour of double pointer is the same as a 1-D array; infact, double pointer is 1-D array holding address of each of different sets of 1-D arrays.
     2. The attached code shows this behaviour.
     
     MEMORY DEALLOCATION POINT OF VIEW
     1. Since a 2-D array is stored in the stack, then allocation and deallocation of memory are done by the compiler - most often deallocation is done when they are out of scope (stack storage behaviour). While a double pointer has to be manually freed by the programmer since they are store in a random manner in the heap (unlike stack with LIFO mode of operation).
     2. The reverse order of allocation of memory will be used during deallocation of double pointer array as shown in the code. More importantly, a double pointer array must be properly deallocated to free up occupied memory location in-order to avoid memory leakage.
     
     */
    unsigned n = 5, m = 7;
    
    double tda[n][m];
    double oda[n];
    
    std::cout
    << "&tda[0][0] =>           " << &tda[0][0] << std::endl
    << "&tda[0]    =>           " <<  tda[0] << std::endl
    << "tda[0]     =>           " <<  tda[0] << std::endl
    << "tda        =>           " << tda << std::endl;
    
    
    
    double** dpa = new double*[n];
    for(int i=0; i < n; i++) dpa[i] = new double[m];
    
    std::cout
    << "\n&dpa[0][0] =>           " << &dpa[0][0] << std::endl
    << "dpa[0]     =>           " <<  dpa[0] << std::endl
    << "&dpa[0]    =>           " <<  &dpa[0] << std::endl
    << "dpa        =>           " << dpa << std::endl;
    
    std::cout
    << "\n&oda[0]    =>           " <<  &oda[0] << std::endl
    << "oda        =>           " << oda << std::endl;
    
    for(int i=0; i < n; i++) delete[] dpa[i];
    delete[] dpa;
    
    return 0;
}
#endif
