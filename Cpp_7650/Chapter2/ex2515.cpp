//
//  ex2515.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-20.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

//#include <iostream>
//
//int main(int argc, const char * argv[]){
//    
//    int n;
//    int m = sizeof(int)*8;
//    int mask = 1 << (m-1);                         //mask = 10000000000000000000000000000000 in bit representation
//    
//    for (; ; ) {                                // infinite loop
//        std::cout << "\nEnter an integer: ";
//        
//        std::cin >> n;                          // input is assigned to n
//        
//        if(n == 0) break;
//        
//        std::cout << "Bit representation of " << n << " is: ";
//        for (int i = 1; i <= m; i++) {
//            char cc = (n & mask) ? '1' : '0';   // take bit i from left to right
//            std::cout << cc;                    // print bit i from left to right
//            n <<= 1;                            // n = n<< 1; left shift n by 1 bit
//            
//            if(i%8 == 0 && i != m) std::cout << ' ';       //print one space after each of byte
//        }
//    }
//    
//    return 0;
//}
