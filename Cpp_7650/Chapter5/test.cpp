//
//  test.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-11-17.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <stdio.h>
//#include <complex>
#include <iostream>
#include <typeinfo>
//#include "cmplx.h"
//#define RUN_SECTION
class Shape {

public:
    virtual void draw()=0;
};

class A : public Shape {
public:
    void draw(){ std::cout << "A\n"; };
};
class B : public Shape {
public:
    void draw(){ std::cout << "B\n"; };

};

class C : public A, protected B {
    
    //void draw();
};

class myInfo{};

#ifdef RUN_SECTION

int main(){
//    cplx<float> cf(3,4);
//    cplx<double> cd(5,6);
//    
//    cd=cf ;
//    //cf=cd;
//    cf = cplx<float>(cd);
    
    C* p;
    A* q1 = p;
    A* q2 = dynamic_cast<C*>(p);
    
    //B* p1 = p;
    //B q3 = *dynamic_cast<C*>(p);
    
    B* pb;
    dynamic_cast<A*>(pb);
    if(A* pa = dynamic_cast<A*>(pb))
        std::cout << "good" << std::endl;
    else
        std::cout << "not good" << std::endl;
    
    char charr[7][32];
    
    //std::cout << sizeof(charr) << std::endl;
    
    myInfo test; char aaa;
    std::cout << typeid(aaa).name() << std::endl;
    
    return 0;
}
#endif
