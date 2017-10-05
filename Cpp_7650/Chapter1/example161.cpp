//
//  example161.cpp
//  Chapter1
//
//  Created by Mojolagbe Mojolagbe on 2017-09-13.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

//#include <iostream>
//#include <math.h>
//
//int main(int argc, const char * argv[]) {
//    int n, m;                                                                       //declare n and mto be integers
//    std::cout<< "Enter two integers : \n";                                          // output to screen
//    std::cin >> n >> m;                                                             //input will be assigned to n, m
//    
//    
//    if(n > m) {                     //if n is bigger than m, swap them
//        int temp = n;               // declare temp and initialize it
//        n = m;                      // assign value of m to an
//        m = temp;                   // assign value of temp to m
//    }
//    
//    long double sumDouble = 0.0;                                                    // sumDouble has double precision
//    int sumInt = 0;                                                                 // sumInt has integer precision
//    
//    // a loop, i changes from n to m with increment 1 each time
//    for (int i = n; i <= m; i++) {                                                  // <=: less than or equal to
//        sumDouble += pow(i, 2);                                                     //pow() method is contained in the math library
//        sumInt +=  pow(i, 2);                                                       // implicit type casting takes place here
//    }
//    std::cout<< "(Double) Sum of square of integers from "<< n << " to "<< m << " is: "<< sumDouble << '\n'; // output sumDouble to screen
//    std::cout<< "(Int) Sum of square of integers from "<< n << " to "<< m << " is: "<< sumInt << '\n'; // output sumDouble to screen
//    
//    //std::cout << sizeof(sumInt) << std::endl;
//    int startVal = 1,                                                               // declare two variables to hold start and end values of the loop
//        endVal = 5000;
//    int result = 0;                                                               // declare result to hold sum of the squares as int (inorder to have overflow)
//    
//    for (int i = startVal; i <= endVal; i++) {                                      // <=: less than or equal to
//        result += pow(i, 2);                                                        //pow() method is contained in the math library
//    }
//    std::cout<< "Sum of square of integers from "<< startVal << " to "<< endVal << " is: "<< result << '\n'; // output result to screen
//    
//    return 0;
//}
