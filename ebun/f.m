function [result] = f(c_al,c_0, c_la, K, n_max)
% Function that computes f(k) 
%   at a given iteration.
c = (c_al - c_0) / (c_la - c_al);

sigma = 0.;
for n = 1:n_max
    sigma = sigma + (((-1).^n)*(K.^(2*n + 1))) / ((2*n + 1)*factorial(n));
end

sub_ = K*(1 + (2/sqrt(pi)) * sigma);
result = c - (sqrt(pi)*(sub_) / exp(-K*K));
end

