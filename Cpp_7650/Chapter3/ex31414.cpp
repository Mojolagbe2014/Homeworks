//
//  ex31414.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-09-26.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#include <iostream>

//#define RUN_SECTION
#ifdef RUN_SECTION

int main(int argc, const char * argv[]){
    int p =4, q =2, r =3, s= 2; // or computed at run-time
    
    double**** p4d = new double***[p]; // allocate space
    for (int i = 0; i < p; i++) {
        p4d[i] = new double**[q];
        for (int j = 0; j < q; j++){
            p4d[i][j] = new double*[r];
            for (int k = 0; k < r; k++) p4d[i][j][k] = new double[s];
        }
    }
    
    for (int i = 0; i < p; i++) // access its entries
        for (int j = 0; j <q; j++)
            for (int k = 0; k < r; k++)
                for (int m = 0; m < s; m++) p4d[i][j][k][m] = i - j + k - m;
    
    for (int i = 0; i < p; i++) { // delete space after use
        for (int j = 0; j < q; j++){
            for (int k = 0; k < r; k++) {
                delete[] p4d[i][j][k];
            }
            delete[] p4d[i][j];
        }
        delete[] p4d[i];
    }
    delete[] p4d;
    
    return 0;
}
#endif
