//
//  main.cpp
//  Arithmetic
//
//  Created by Mojolagbe Mojolagbe on 2017-10-07.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//
//
#include <iostream>
#include "Arithmetic.h"

int main(int argc, const char * argv[]) {
    
    double a = 7.3;
    double b = 2.5;
    
    Arithmetic::SimpleArithmetic arith;
    
    std::cout <<  a << " + " << b << " = " << Arithmetic::SimpleArithmetic::sum(a, b) << std::endl;
    std::cout <<  a << " - " << b << " = " << Arithmetic::SimpleArithmetic::subtract(a, b) << std::endl;
    std::cout <<  a << " * " << b << " = " << Arithmetic::SimpleArithmetic::product(a, b) << std::endl;
    //std::cout <<  a << " / " << b << " = " << Arithmetic::SimpleArithmetic::divide(a, b) << std::endl;
    std::cout <<  a << " / " << b << " = " << arith.divide(a, b) << std::endl;
    return 0;
}
