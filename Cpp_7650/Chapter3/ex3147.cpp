//
//  ex3143.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

//#include <iostream>
//#include <math.h>
//
//struct complx {
//    double real;
//    double img;
//};
//
//void quadratic(double, double, double);
//
//int main(int argc, const char * argv[]){
//    int a = 3, b = -3, c = 2;
//    
//    quadratic(a, b, c);
//    
//    return 0;
//}
//
//
//
//void quadratic(double a, double b, double c){
//    
//    if(a == 0 && b != 0){
//        double x = -c/b;
//        std::cout << " x = " << x << std::endl;
//    }
//    else if(a != 0){
//        double x1, x2;
//        double d = pow(b, 2) - (4*a*c);
//        
//        // Handle complex solution
//        if(d < 0){
//            complx x1, x2;
//            d *= -1;
//            x1.real = -b / (2. * a);
//            x1.img = sqrt(d) / (2. * a);
//            
//            x2.real = x1.real;
//            x2.img = -x1.img;
//            
//            std::cout.precision(15);
//            std::cout << " x1 = " << x1.real << ((x1.img > 0) ? " + " : " - ") << x1.img << "i" << std::endl;
//            
//            std::cout.precision(15);
//            std::cout << " x2 = " << x2.real << ((x2.img > 0) ? " + " : " - ") << -1. * x2.img << "i" << std::endl;
//            
//            return;
//        }
//        
//        x1 = (-b + sqrt(d)) / (2 * a);
//        x2 = (-b - sqrt(d)) / (2 * a);
//        
//        std::cout.precision(15);
//        std::cout << " x1 = " << x1 << std::endl;
//        
//        std::cout.precision(15);
//        std::cout << " x2 = " << x2 << std::endl;
//        
//    }
//}
//
