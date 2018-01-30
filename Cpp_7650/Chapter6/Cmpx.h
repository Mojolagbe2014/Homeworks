//
//  Cmpx.hpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-01-01.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#ifndef Cmpx_hpp
#define Cmpx_hpp

#include <stdio.h>
#include <fstream>
#include <iostream>

class Cmpx { private:
    double re;
    double im;

public:
    Cmpx(double x=0, double y=0.) { re = x; im = y; };
    Cmpx& operator+=(Cmpx);
    Cmpx& operator-=(Cmpx);
    
    friend Cmpx operator*(Cmpx, Cmpx);
    friend std::ostream& operator<<(std::ostream&, Cmpx);
    friend std::istream& operator>>(std::istream&, Cmpx);
};

Cmpx operator+(Cmpx);           // unary +,  z1 = +z1
Cmpx operator-(Cmpx);           // unary -,  z1 = -z1
Cmpx operator+(Cmpx, Cmpx);     // binary +, z3 = z1 + z2
Cmpx operator-(Cmpx, Cmpx);     // binary -, z3 = z1 - z2

#endif /* Cmpx_hpp */
