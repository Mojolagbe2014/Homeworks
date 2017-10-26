//
//  ex3148.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
#include <math.h>

//#define RUN_SECTION
#ifdef RUN_SECTION

int main(int argc, const char * argv[]){
    unsigned n = 10, count = 3, i = 0;
    
    double a[count];
    
    a[i] = 2.;
    
    a[i++] *= n;
    a[i++] = a[i++]*n;
    
    std::cout << a[0] << std::endl << i << std::endl;
    
    return 0;
}
#endif
