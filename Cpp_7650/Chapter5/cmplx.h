//
//  cmplx.h
//  Cpp4Engineers
//
//  Created by Mojolagbe Mojolagbe on 2017-11-17.
//  Copyright © 2017 TIMCA Computers. All rights reserved.
//

#ifndef cmplx_h
#define cmplx_h
template<class T> class cplx {
    T re, im;
    
public:
    cplx(const T& r = T(), const T& i = T());
    template<class S> cplx(const cplx<S>&);
    cplx<T>& operator=(const T&);
    template<class S> cplx<T>& operator=(const cplx<S>&);
    T real() const { return re; }
    T imag() const { return im; }
    
};

template<> class cplx<float> {
    float re, im;
    
public :
    cplx(float r = 0.0, float i = 0.0);
    cplx(const cplx<float>&);
    explicit cplx(const cplx<double>&);
    explicit cplx(const cplx<long double>&);
};
#endif /* cmplx_h */
