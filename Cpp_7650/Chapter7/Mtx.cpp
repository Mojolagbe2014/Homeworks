//
//  Mtx.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-01-30.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#include "Mtx.h"

template<typename T> Mtx<T>::Mtx(int n, int m, T** dbp) { // constructor
    nrows = n;
    ncols = m;
    ets = new T* [nrows];
    
    for(int i = 0; i < nrows; i++){
        ets[i] = new T[ncols];
        for (int j=0; j<ncols; j++) ets[i][j] = dbp[i][j];
        
    }
}

template<typename T> Mtx<T>::Mtx(int n, int m, T a) { // constructor
    ets = new T* [nrows = n] ;
    ncols = m;
    
    for (int i = 0; i< nrows; i++) {
        ets[i] = new T[ncols];
        for (int j = 0; j <ncols; j++) ets[i][j] = a;
    }
}

template<typename T> Mtx<T>::Mtx(const Mtx<T>& mat) { // copy constructor
    ets = new T* [nrows = mat.nrows];
    ncols = mat.ncols;
    for (int i = 0; i< nrows; i++) {
        ets[i] = new T[ncols];
        for (int j = 0; j < ncols; j++) ets[i] [j] = mat[i][j];
    }
}

template<typename T> inline Mtx<T>::~Mtx(){ // destructor
    for (int i = 0; i< nrows ; i++) delete[] ets[i];
    delete[] ets;
}

template<typename T> Mtx<T>& Mtx<T>::operator=(const Mtx<T>& mat) { // copy assignment
    if (this != &mat) {
        if (nrows != mat.nrows || ncols != mat.ncols) std::cerr << "\nBad matrix sizes\n";
        
        for (int i = 0; i < nrows; i++)
            for (int j = 0; j < ncols; j++)
                ets[i][j] = mat[i][j];
    }
    
    return *this;
}

template<typename T> Mtx<T>& Mtx<T>::operator+=(const Mtx<T>& mat) { // add-assign
    if (nrows != mat.nrows || ncols != mat.ncols){
        std::cerr << "\nBad matrix sizes\n";
        exit(1);
    }
    
    for (int i =0; i <nrows; i++)
        for (int j = 0; j < ncols; j++)
            ets[i][j] += mat[i][j];
    return *this;
}

template<typename T> Mtx<T>& Mtx<T>::operator-=(const Mtx<T>& mat) { // subtract-assign
    if (nrows != mat.nrows || ncols != mat.ncols){
        std::cerr << "\nBad matrix sizes\n";
        exit(1);
    }
    
    for (int i =0; i <nrows; i++)
        for (int j = 0; j < ncols; j++)
            ets[i][j] -= mat[i][j];
    
    return *this;
}

template<typename T> inline Mtx<T>& Mtx<T>::operator+() const { // usage: ml = + m2
    return *this;
}

template<typename T> inline Mtx<T> operator-(const Mtx<T>& mat)  { // usage: ml = -m2
    return (Mtx<T>(mat.nrows, mat.ncols) - mat);
}

template<typename T> Mtx<T> Mtx<T>::operator+(const Mtx<T>& mat) const { // m = m1 + m2
    if (nrows != mat.nrows || ncols != mat.ncols){
        std::cerr << "\nBad matrix sizes\n";
        exit(1);
    }
    
    Mtx<T>  sum = *this;                            // user defined copy constructor
    sum += mat;                                     // is important here
    return sum;                                     // otherwise m1 would be changed
}


template<typename T> Mtx<T> operator-(const Mtx<T>& m1, const Mtx<T>& m2) { // m = m1 - m2
    if(m1.nrows != m2.nrows || m1.ncols != m2.ncols){
        std::cerr << "\nBad matrix sizes\n";
        exit(1);
    }
    
    Mtx<T>  sum = m1;                               // user defined copy constructor
    sum -= m2;                                      // is important here
    return sum;                                     // otherwise m1 would be changed
}

template<typename T> Vcr<T> Mtx<T>::operator*(const Vcr<T>& v) const { // u = m*v
    if (ncols != v.size())
        std::cerr << "\nMatrix and vector sizes do not match\n";
    
    Vcr<T> tm(nrows);
    for (int i = 0; i < nrows; i++)
        for (int j = 0; j < ncols; j++)
            tm[i] += ets[i][j]*v[j];
    
    return tm;
}

template<typename T> std::ostream& operator<<(std::ostream& s, const Mtx<T>& v) {                 // output stream
    for (int i = 0; i < v.nrows; i++){
        s <<  " |";
        for (int j = 0; j < v.ncols; j++){
            s.precision(2);
            s << " " << v[i][j]  << " ";
        }
        s <<  "| \n";
    }
    
    return s;
}


template<typename T> int Mtx<T>::CG(Vcr<T>& x, const Vcr<T>& b, double& eps, int& iter) {
    if (nrows != b.size()){
        std::cout << "\nMatrix and vector sizes do not match\n";
        exit(1);
    }
    const int maxiter = iter;
    Vcr<T> r = b - (*this)*x;                                  // initial residual
    Vcr<T> p = r;                                              // p: search direction
    T zr = dot(r,r);                                      // inner product of r and r
    const T stp = eps*b.twonorm();                        // stopping criterion
    
    if (r.twonorm() == 0) {                                 // if initial guess is true soln,
        eps =0.0;                                           // return. Othervise division by
        iter = 0;                                           // zero would occur.
        return 0;
    }
    
    for (iter = 0; iter < maxiter; iter++) {                // main loop
        Vcr<T> mp = (*this)*p;                              // matrix-vector multiply
        T alpha = zr/dot(mp,p);                        // divisor=0 only if r = 0
        x += alpha*p;                                       // update iterative soln
        r -= alpha*mp;                                      // update residual
        if (r.twonorm() <= stp) break;                      // stop if converged
        T zrold = zr;
        zr = dot(r,r);                                      // dot product
        p = r + (zr/zrold)*p;                               // zrold = 0 only if r = 0
    }

    eps = r.twonorm();
    if (iter == maxiter) return 1;
    else return 0;
}
