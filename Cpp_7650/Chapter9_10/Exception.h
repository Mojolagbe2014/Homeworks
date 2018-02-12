//
//  Exception.h
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-02-11.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#ifndef Exception_h
#define Exception_h
#include <string>
#include <iostream>

class MVerr{  // base class
public :
    virtual void print() const {
        std::cout << "Matrix vector error\n";
    }
};

class IntOverflow : public MVerr { // integer overflow
    std::string op;
public:
    IntOverflow(std::string p) { op = p; }
    void print() const {
        MVerr::print();
        std::cout << "Integer Overflow: " << op << std::endl;
    }
};

class FloatOverflow : public MVerr { // floating point overflow
    std::string op;
public:
    FloatOverflow(std::string p) { op = p; }
    void print() const {
        MVerr::print();
        std::cout << "Floating Point Overflow: " << op << std::endl;
    }
};

class SmallDivisor : public MVerr { // small or zero divisor
    std::string op;
public:
    static const double Small;                                          // smallest divisor
    double sd;
    SmallDivisor(double d, std:: string p) { sd =d; op = p; }           // constructor
    
    void print() const {
        MVerr::print();
        std::cout << "Zero or Small Divisor: " << op << std::endl;
    }
};

class NoMatch : public MVerr { // matrix vector sizes do not match
    std::string op;
public :
    NoMatch(std::string p) { op = p; }
    void print() const {
        MVerr::print();
        std::cout << "No Match in operation: " << op << '\n';
    }
};

#endif /* Exception_h */
