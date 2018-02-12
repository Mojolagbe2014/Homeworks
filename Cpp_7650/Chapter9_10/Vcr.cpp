//
//  Vcr.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-01-29.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//
#include "Vcr.h"

template<typename T> Vcr<T>::Vcr(int n, const T* const abd){  // constructor
    vr = new T[length=n];
    for(int i = 0; i < length; i++) vr[i] = *(abd+i);
}

template<typename T> Vcr<T>::Vcr(int n, T val){  // constructor
    vr = new T[length=n];
    for(int i = 0; i < length; i++) vr[i] = val;
}


template<typename T> Vcr<T>::Vcr(const Vcr<T>& v){  // copy constructor
    vr = new T[length = v.length];
    for(int i = 0; i < length; i++) vr[i] = v[i];
}

template<typename T> Vcr<T>& Vcr<T>::operator=(const Vcr<T>& v){  // copy assignment
    if(this != &v) {
        if(length != v.length) throw NoMatch("Copy Assignment");
        for(int i = 0; i < length; i++) vr[i] = v[i];
    }
    return *this;
}

template<typename T> inline Vcr<T> operator+(const Vcr<T>& v) { return v; } //unary + : u = +v

template<typename T> inline Vcr<T> operator-(const Vcr<T>& v) { return Vcr<T>(v.size()) - v; } //unary - : u = -v

template<typename T> Vcr<T> operator+(const Vcr<T>& v1, const Vcr<T>& v2){         // binary +, v = v1 + v2
    if (v1.length != v2.length) throw NoMatch("Vector Addition");
    Vcr<T> temp = v1;  // create temporary vector
    temp += v2;
    return temp;
}

template<typename T> Vcr<T> operator-(const Vcr<T>& v1, const Vcr<T>& v2){         // binary -, v = v1 - v2
    if (v1.length != v2.length) throw NoMatch("Vector Subtraction");
    Vcr<T> temp = v1;  // create temporary vector
    temp -= v2;
    return temp;
}

template<typename T> Vcr<T>& Vcr<T>::operator+=(const Vcr<T>& v){ // binary operator +=
    if(length != v.length) throw NoMatch("Binary operator += ");
    for(int i = 0; i < length; i++) vr[i] += v[i];
    return *this;
}

template<typename T> Vcr<T>& Vcr<T>::operator-=(const Vcr<T>& v){ // binary operator -=
    if(length != v.length) throw NoMatch("Binary operator -=");
    for(int i = 0; i < length; i++) vr[i] -= v[i];
    return *this;
}

template<typename T> Vcr<T> operator*(T scalar, const Vcr<T>& v){                     // scalar-vector multiply
    Vcr<T> tm(v.length);
    for(int i = 0; i < v.length; i++) tm[i] = scalar * v[i];
    return tm;
}

template<typename T> inline Vcr<T> operator*(const Vcr<T>& v, T scalar) {       // vector-scalar multiply
    return scalar*v;
}

template<typename T> Vcr<T> operator/(const Vcr<T> & v, T scalar) {              // vector-scalar divide
    if (!scalar) throw NoMatch("Vector - Scalar division");
    return (1.0/scalar)*v;
}

template<typename T> Vcr<T> operator*(const Vcr<T>& v1, const Vcr<T>& v2) {     // vector multiply
    if (v1.length != v2.length) throw NoMatch("Vector - Vector Multiplication");
    int n = v1.length;
    Vcr<T> tm(n);
    for (int i = 0; i < n; i++) tm[i] = v1[i]*v2[i];
    return tm;
}

template<typename T> T Vcr<T>::twonorm() const { // 2 - (euclidean) norm
    T norm = vr[0] * vr [0] ;
    for(int i = 1; i < length; i++) norm += vr[i]*vr[i];
    return sqrt(norm);
}


template<typename T> T Vcr<T>::maxnorm() const {    // maximum norm
    T nm = std::abs(vr[0]);
    for(int i = 1; i < length; i++) nm = std::max(nm, std::abs(vr[i]));
    
    return nm;
}

template<typename T> T dot(const Vcr<T>& v1, const Vcr<T>& v2) { // dot product
    if (v1.length != v2.length) throw NoMatch("Inner (dot) Product");
    T tm = v1[0]*v2[0];
    
    for(int i = 1; i < v1.length; i++) tm += v1[i] * v2[i];
    
    return tm;
}

template<typename T> std::ostream& operator<<(std::ostream& s, const Vcr<T>& v) {                 // output stream
    for (int i =0; i <v.length; i++ ) {
        s << v[i] << "\n";
        //s << v[i] << " ";
        //if (i%10 == 9) s << "\n"; // print 10 elements on a line
    }
    return s;
}






// ******* a specialization of Vcr<T> for complex numbers ******** //

template<typename T> Vcr< std::complex<T> >::Vcr(int n, const std::complex<T>* const abd) { // constructor
    vr = new std::complex<T> [length = n] ;
    for (int i = 0; i < length; i++) vr[i] = *(abd +i);
}

template<typename T> Vcr<std::complex<T>>::Vcr(int n, std::complex<T> val){  // constructor
    vr = new std::complex<T>[length=n];
    for(int i = 0; i < length; i++) vr[i] = val;
}


template<typename T> Vcr<std::complex<T>>::Vcr(const Vcr<std::complex<T>>& vec) { // copy constructor
    vr = new std::complex<T>[length=vec.length];
    for (int i = 0; i < length; i++) vr[i] = vec[i];
}

template<typename T> Vcr<std::complex<T>>& Vcr<std::complex<T>>::operator=(const Vcr<std::complex<T>>& v){  // copy assignment =
    if(this != &v) {
        if(length != v.length) throw NoMatch("Copy Assignment");
        for(int i = 0; i < length; i++) vr[i] = v[i];
    }
    return *this;
}

template<typename T> Vcr<std::complex<T>>& Vcr<std::complex<T>>::operator+=(const Vcr<std::complex<T>>& v){ // binary operator +=
    if(length != v.length) throw NoMatch("Binary operator +=");
    for(int i = 0; i < length; i++) vr[i] += v[i];
    return *this;
}

template<typename T> Vcr<std::complex<T>>& Vcr<std::complex<T>>::operator-=(const Vcr<std::complex<T>>& v){ // binary operator -=
    if(length != v.length) throw NoMatch("Binary operator -=");
    for(int i = 0; i < length; i++) vr[i] -= v[i];
    return *this;
}

template<typename T> inline Vcr<std::complex<T>> operator+(const Vcr<std::complex<T>>& v) { return v; } //unary + : u = +v

template<typename T> inline Vcr<std::complex<T>> operator-(const Vcr<std::complex<T>>& v) { return Vcr<std::complex<T>>(v.size()) - v; } //unary - : u = -v

template<typename T> Vcr<std::complex<T>> operator+(const Vcr<std::complex<T>>& v1, const Vcr<std::complex<T>>& v2){         // binary +, v = v1 + v2
    if (v1.length != v2.length) throw NoMatch("Vector Addition");
    Vcr<std::complex<T>> temp = v1;  // create temporary vector
    temp += v2;
    return temp;
}

template<typename T> Vcr<std::complex<T>> operator-(const Vcr<std::complex<T>>& v1, const Vcr<std::complex<T>>& v2){         // binary -, v = v1 - v2
    if (v1.length != v2.length) throw NoMatch("Vector Subtraction");
    Vcr<std::complex<T>> temp = v1;  // create temporary vector
    temp -= v2;
    return temp;
}

template<typename T> Vcr<std::complex<T>> operator*(T scalar, const Vcr<std::complex<T>>& v){                     // scalar-vector multiply
    Vcr<std::complex<T>> tm(v.length);
    for(int i = 0; i < v.length; i++) tm[i] = scalar * v[i];
    return tm;
}

template<typename T> Vcr<std::complex<T>> operator*(std::complex<T> scalar, const Vcr<std::complex<T>>& v){     // scalar-vector multiply
    Vcr<std::complex<T>> tm(v.length);
    for(int i = 0; i < v.length; i++) tm[i] = scalar * v[i];
    return tm;
}

template<typename T> inline Vcr<std::complex<T>> operator*(const Vcr<std::complex<T>>& v, T scalar) {       // vector-scalar multiply
    return scalar*v;
}

template<typename T> inline Vcr<std::complex<T>> operator*(const Vcr<std::complex<T>>& v, std::complex<T> scalar) {       // vector-scalar multiply
    return scalar*v;
}


template<typename T> Vcr<std::complex<T>> operator/(const Vcr<std::complex<T>> & v, T scalar) {              // vector-scalar divide
    if (!scalar) throw NoMatch("Vector - Scalar Division");
    return (1.0/scalar)*v;
}

template<typename T> Vcr<std::complex<T>> operator/(const Vcr<std::complex<T>> & v, std::complex<T> scalar) {              // vector-scalar divide
    if (!scalar) throw NoMatch("Vector - Complex Scalar Division");
    return (1.0/scalar)*v;
}

template<typename T> Vcr<std::complex<T>> operator*(const Vcr<std::complex<T>>& v1, const Vcr<std::complex<T>>& v2) {     // vector multiply
    if (v1.length != v2.length) throw NoMatch("Vector - Vector Multiplication");
    int n = v1.length;
    Vcr<std::complex<T>> tm(n);
    for (int i = 0; i < n; i++) tm[i] = v1[i]*v2[i];
    return tm;
}

template<typename T> T Vcr<std::complex<T>>::maxnorm() const { // maximum norm
    T nm = std::abs(vr[0]);
    for(int i = 1; i < length; i++) nm = std::max(nm, std::abs(vr[i]));
    return nm;
}

template<typename T> std::complex<T> dot(const Vcr<std::complex<T>>& v1, const Vcr<std::complex<T>>& v2) { // dot product
    if (v1.length != v2.length) throw NoMatch("Inner (dot) Product");
    std::complex<T> tm = v1[0] * conj(v2[0]);                           // conjugate of v2
    
    for(int i = 1; i < v1.length; i++) tm += v1[i] * conj(v2[i]);
    
    return tm;
}

template<typename T> std::ostream& operator<<(std::ostream& s, const Vcr<std::complex<T>>& v) {                 // output stream
    for (int i =0; i <v.length; i++ ) {
        s << v[i] << "\n";
        //s << v[i] << " ";
        //if (i%10 == 9) s << "\n"; // print 10 elements on a line
    }
    return s;
}

template<typename T> T Vcr<std::complex<T>>::twonorm() const { // 2 - (euclidean) norm
    T norm = std::abs(vr[0]) * std::abs(vr [0]) ;
    for(int i = 1; i < length; i++) norm += std::abs(vr[i])*std::abs(vr[i]);
    return sqrt(norm);
}









