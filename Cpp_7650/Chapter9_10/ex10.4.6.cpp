//  ex10.4.6.cpp
//  Cpp4Engineers
//#define RUN_SECTION
#ifdef RUN_SECTION

#include <stdio.h>
#include <iostream>
#include <set>
#include <algorithm>
#include <stdlib.h>     /* srand, rand */
#include <time.h>       /* time */

int main(){
    unsigned n = 10;
    std::set<int> v;
    
    srand(time(0));
    for (int i = 0; i < n; i++) v.insert(rand() % 50 + 1);
    
    std::cout << "Elements of the set are: \n";
    for (auto p = v.begin(); p != v.end(); p++) std::cout << *p << '\n';
    
    int sum = 0;
    
    for (std::set<int>::const_iterator p = v.begin(); p != v.end(); p++) sum += *p;
    
    std::cout << "\nSum = " << sum << std::endl;
    
    return 0;
}

#endif
