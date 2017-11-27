//
//  ex3143.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
//#define RUN_SECTION

#ifdef RUN_SECTION
int sumsq(int n, int m);

int main(int argc, const char * argv[]){

    std::cout << sumsq(2, 5) << std::endl;

    return 0;
}


int sumsq(int n, int m){
    
    if(n > m) {                     //if n is bigger than m, swap them
        int temp = n;               // declare temp and initialize it
        n = m;                      // assign value of m to n
        m = temp;                   // assign value of temp to m
    }
    
    int sum = 0;
    for(unsigned i = n; i <= m; i++)    sum += i*i;
    
    return sum;
}
#endif
