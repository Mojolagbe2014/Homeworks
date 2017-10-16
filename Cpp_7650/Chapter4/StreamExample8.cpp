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
int main(int argc, const char * argv[]) {
    std::ifstream infile("data/readfile.txt", std::ios_base::in);
    char c;
    int n = 0, m = 0;
    while(infile.get(c) ) {
    //while(infile.read(&c, 1) ) { // read 1 char at a time
        switch(c) {
            case',' : n++; break;
            case '\n': m++; break;
        }
        c = toupper(c);
        //std::cout.write(&c, 1); // write c on screen
        std::cout.put(c); // write c on screen
    }
    std::cout << "There are " << n << " commas and " << m << " lines in the input file.\n";
    
    return 0;
}
#endif
