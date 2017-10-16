//
//  StringExample.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-09.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <fstream>
#include <stdlib.h>
#include <iostream>
//#define RUN_SECTION
#ifdef RUN_SECTION
void f(std::istream& ism);


int main(int argc, const char * argv[]) {
    std::ifstream infile("data/readfile.txt", std::ios_base::in);
    f(infile);
    
    return 0;
}


void f(std::istream& ism) {
    int n = 0; char line[1024];
    while (ism.get(line, 1024, '\n') ) {
        n++ ;
        std::cout << "there are " << ism.gcount() << " characters "
        << "on line " << n << '\n';
        ism.ignore(); // ignore terminate character: '\n'
    }
    std::cout << "There are " << n << " lines in input file.\n";
}
#endif
