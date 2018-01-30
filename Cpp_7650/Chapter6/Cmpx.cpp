//
//  Cmpx.cpp
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2018-01-01.
//  Copyright © 2018 TIMCA Computers. All rights reserved.
//

#include "Cmpx.h"
inline Cmpx operator+(Cmpx z) { return z; }
inline Cmpx operator-(Cmpx z) { return 0 - z; }

inline Cmpx& Cmpx::operator+=(Cmpx z) {
    re += z.re;
    im += z.im;
    return *this;
}

inline Cmpx& Cmpx::operator-=(Cmpx z) {
    re -= z.re; im -= z.im;
    return *this;
}
inline Cmpx operator+(Cmpx a, Cmpx b) {  return a += b; }

inline Cmpx operator-(Cmpx a, Cmpx b) {  return a -= b; }

inline Cmpx operator*(Cmpx a, Cmpx b) {
    return Cmpx(a.re*b .re - a. im*b.im, a.re*b.im + a.im*b.re);
}

std::ostream& operator<<(std::ostream& s, Cmpx z) {
    s<< "(" << z.re << ","<< z.im << ")";
    return s;
}

std::istream& operator>>(std::istream& s, Cmpx z) {
    s >> z.re >> z.im;
    return s;
}
