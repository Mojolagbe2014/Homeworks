//
//  ex7.9.1.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-01-29.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#include <stdio.h>
#include <iostream>
#include <cmath>
#include "Vcr.cpp"



#define RUN_SECTION

#ifdef RUN_SECTION
using namespace std;

int main(int argc, char* argv[]){

    Vcr<float> fv(20);
    Vcr<double> dv(3, 2.);
    Vcr<double> dv2(3, 3.);
    
    dv += dv2;
    Vcr<double> dv3 = dv;
    
    dv3 = dv/2.;
    
    std::cout << dv << std::endl;
    std::cout << dv2 << std::endl;
    std::cout << dv3 << std::endl;
    
    //for(int i = 0; i < 3; i++) std::cout << std::endl << dv3[i] << std::endl;
    //std::cout << std::endl << dv3.twonorm() << std::endl;
    //std::cout << std::endl << dot(dv, dv2) << std::endl;
        
    return 0;
}
#endif
