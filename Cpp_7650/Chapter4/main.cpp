//
//  main.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-10-04.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <stdio.h>
#include <iostream>
//#define RUN_SECTION

#ifdef RUN_SECTION
int main (){
    
    // open file for write and append
    ofstream wafile("item2.txt", ios_base::out | ios_base::app);
    // open file for read and write
    fstream rwfile("item3.txt", ios_base::in | ios_base::out);
    return 0;
}
#endif


