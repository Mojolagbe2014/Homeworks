//
//  Mtx.hpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-01-30.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#ifndef Mtx_h
#define Mtx_h

#include <stdio.h>
#include <fstream>
#include "Vcr.h"

template<typename T> class Mtx {
    int nrows;                                  // number of rows
    int ncols;                                  // number of columns
    T** ets;                                    // entries of matrix
    
public:
    Mtx(int n, int m, T**);                     // constructor (n by m)
    Mtx(int n, int m, T d = 0.);                // all entries equal d
    Mtx(const Mtx&);                            // copy constructor
    ~Mtx();                                     // destructor
    
    Mtx& operator=(const Mtx&);                 // overload = : copy assignment
    Mtx& operator+=(const Mtx&);                // overload +=
    Mtx& operator-=(const Mtx&);                // overload -=
    Vcr<T> operator*(const Vcr<T>&) const;      // matrix-vector multiplication
    
    
    T* operator[](int i) const{ return ets[i]; }                                        // subscript - row
    T& operator()(int i, int j) const { return ets[i][j]; }                             // subscript - (i, j)th entry
    
    Mtx& operator+() const;                                                             // unary +, m1 = +m2
    Mtx operator+(const Mtx&) const;                                                    // binary +, m = m1 + m2
    
    template<typename S> friend Mtx<S> operator-(const Mtx<S>&);                        // unary -, m1 = -m2;
    template<typename S> friend Mtx<S> operator-(const Mtx<S>&, const Mtx<S>&);         // binary -
    template<typename S> friend std::ostream& operator<<(std::ostream&, const Mtx<S>&); // output operator
    template<typename S> friend std::ostream& operator<<(std::ostream&, const Mtx<S>&); // output operator
    
    /**
     Conjugate gradient method for Ax = b.
     It returns 0 for successful return and 1 for breakdowns
     
     A:     symmetric positive definite coefficient matrix
     x:     on entry: initial guess; on return: approximate soln b: right side vector
     
     eps:   on entry: stopping criterion, epsilon
            on return: absolute residual in two-norm for approximate solution
     
     iter : on entry: max number of iterations allowed;
            on return: actual number of iterations taken.
    */
    int CG(Vcr<T>& x, const Vcr<T>& b, double& eps, int& iter);
};

#endif /* Mtx_hpp */
