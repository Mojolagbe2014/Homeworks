//
//  ex2512.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-20.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//


#include <iostream>
#include <math.h>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]){
    
    unsigned int largeui = -1;
    
//    int i = -1;
//    unsigned int largeui = i;
//    https://msdn.microsoft.com/en-us/library/hh279667.aspx
    
    std::cout << largeui << std::endl;                                      // what happens here is implicit conversion of int to unsigned and
                                                                            // prints equivalent unsigned value largeui = 4294967295; i.e 2^(sizeof(unsigned int)*8)
                                                                            // I presume the value is converted using two's complement
    std::cout << std::numeric_limits<unsigned int>::max() << std::endl;
    std::cout << sizeof(unsigned int) << std::endl;
    std::cout << pow(2, (sizeof(unsigned int)*8)) << std::endl;
    
    return 0;
}
#endif
