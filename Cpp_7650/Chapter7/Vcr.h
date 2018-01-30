//
//  Vcr.hpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-01-29.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#ifndef Vcr_h
#define Vcr_h
#include <iostream>
#include <fstream>
#include <cmath>

template<typename T> class Vcr {
    int length;                                     // number of entries
    T* vr;                                          // entries of vector
    
public:
    Vcr(int, const T* const);                       // constructor
    Vcr(int n = 0, T val = 0);                      // constructor
    
    Vcr(const Vcr&);                                // copy constructor
    ~Vcr() { delete[] vr; }                         // destructor
    
    T& operator[](int i) const { return vr[i]; }    // subscripting
    int size() const { return length; }             // number of entries
    T abs(const T& v) const {return v<0 ? -v:v; }   // absolute value
    T maxnorm() const;                              // maximum norm
    T twonorm() const;                              // 2-norm
    
    Vcr& operator=(const Vcr&);                     // copy assignment
    Vcr& operator+=(const Vcr&);                    // binary: v  += v2
    Vcr& operator-=(const Vcr&);                    // binary: v  -= v2
    
    template<typename S> friend Vcr<S> operator+(const Vcr<S>&);                        // unary +, v = + v2
    template<typename S> friend Vcr<S> operator-(const Vcr<S>&);                        // unary -, v =- v2
    template<typename S> friend Vcr<S> operator+(const Vcr<S>&, const Vcr<S>&);         // binary+, v = v1+v2
    template<typename S> friend Vcr<S> operator-(const Vcr<S>&, const Vcr<S>&);         // binary -, v = v1 - v2
    template<typename S> friend S dot(const Vcr<S>&, const Vcr<S>&);                    // dot (inner) product
    template<typename S> friend Vcr<S> operator*(S, const Vcr<S>&);                     // scalar-vector multiply
    template<typename S> friend Vcr<S> operator*(const Vcr<S>&, S);                     // vector-scalar multiply
    template<typename S> friend Vcr<S> operator*(const Vcr<S>&, const Vcr<S>&);         // vector multiply
    template<typename S> friend Vcr<S> operator/(const Vcr<S>&, S);                     // vector-scalar divide
    template<typename S> friend std::ostream& operator<<(std::ostream&, const Vcr<S>&); // output operator
};

#endif /* Vcr_h */
