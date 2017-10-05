//
//  SortRand.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-04.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream> 
#include <time.h>      //for measuring time
#include <stdlib.h>    //for pseudorandom number
#include <algorithm>   //for sort()
//#define RUN_SECTION

#ifdef RUN_SECTION
int main() {
    int n =100000;
    double* dp = new double;
    
    //seed random number generator
    srand(time(0));
    for (int i = 0; i< n; i++) dp[i] = rand()%1000;
    
    std::sort(dp, dp+n); // sort array in increasing order
    
    std::cout << "Sorting Completed!" << std::endl;
}
#endif
