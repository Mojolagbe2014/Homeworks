//  ex9.6.2.cpp
//  Cpp4Engineers
#define RUN_SECTION
#ifdef RUN_SECTION

#include <stdio.h>
#include <iostream>
#include <cmath>
#include "Exception.h"
#include "Vcr.cpp"

using namespace std;

void funky(int x){
    if(x > 0){
        x -=1;
        funky(x);
    }
    std::cout << x << std::endl;
}

int main(int argc, char* argv[]){
//    try {
//        Vcr<double> dv(3, 2.);
//        Vcr<double> dv2(3, 3.);
//        
//        Vcr<double> dv3 = dv * dv2;
//        
//        std::cout << dv3 << std::endl;
//    } catch (IntOverflow e) {
//        e.print();
//    } catch (FloatOverflow e) {
//        e.print();
//    } catch (SmallDivisor e) {
//        e.print();
//    } catch (NoMatch e) {
//        e.print();
//    }
    
//    try {
//        Vcr<double> dv(2, 2.);
//        Vcr<double> dv2(3, 3.);
//        
//        Vcr<double> dv3 = dv * dv2;
//        
//        std::cout << dv3 << std::endl;
//    } catch (MVerr& m) {
//        m.print();
//    }
    funky(5);
    //std::cout << y << std::endl;
    return 0;
}

#endif
