//
//  ConsoleArgument.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-04.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>
#define RUN_SECTION

#ifdef RUN_SECTION
double add(double a, double b) { return a + b; }

int main(int argc, const char * argv[]) {
    switch (argc) {
        case 3:
            double a, b;
            a = atof(argv[1]);
            b = atof(argv[2]);
            
            std::cout<< "Answer = "<< add(a, b) <<  '\n';
            break;
            
        default: std::cout<< "Addition requires atleast 2 inputs."<<  '\n';
            break;
    }
    

    return 0;
}
#endif
