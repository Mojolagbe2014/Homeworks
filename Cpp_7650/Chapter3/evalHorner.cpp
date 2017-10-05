//
//  evalHorner.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-02.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

//#include <iostream>
//#include <cmath>
//
//double eval(double*, int, double);
//double horner(double*, int, double);
//
//int main(){
//
//    double a[9] = {1, - 8, 28, - 56, 70, - 56, 28, - 8, 1};
//    for (double x = 0.99999; x <= 1.0001; x += 1.0e-5) {
//        std::cout.width(18) ;
//        std::cout << eval(a,9,x);               // straightforward evaluation cout.width(18);
//        std::cout.width(18) ;
//        std::cout << horner(a,9,x) ;            // Horner's algorithm
//        std::cout.width(18);
//        std::cout << pow(x-1,8) << '\n';       // direct evaluation
//    }
//    
//    return 0;
//}
//
//
//double eval(double* a, int n, double x){
//    n--;
//    double sum = 0.;
//    for(int k = n; k >= 0; k--) {
//        double xpowerk = 1;
//        for(int i = 1; i <= k; i++){        // or call pow(x, k)
//            xpowerk *= x;                   // compute x to power of k
//        }
//        sum += a[k]*xpowerk;                // add each term to sum
//    }
//    
//    return sum;
//}
//
//
//double horner(double* a, int n, double x){
//    n--;
//    double u = a[n];
//    for(int i = n - 1; i >= 0; i--) u = u*x + a[i];
//    
//    return u;
//}
