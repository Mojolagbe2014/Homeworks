//
//  ex2510.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-20.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main(int argc, const char * argv[]){
    
    double sum = 0.0;
    
    //for(double x = 0.0; x != 5.5; x += 0.1) { // this goes to infinite loop
    for(double x = 0.0; x <= 5.5; x += 0.1) {
        sum += x;
        
        std::cout.precision(32);
        std::cout.width(15);
        std::cout << x << std::endl;
        
    }
    
    return 0;
}
#endif
