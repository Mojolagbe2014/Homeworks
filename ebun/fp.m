function [result] = fp(K, n_max)
% Function that computes f(k) 
%   at a given iteration.
expK = exp(-K*K);

sigma1 = 0.; 
sigma2 = 0.;
for n = 1:n_max
    sigma1 = sigma1 + (((-1).^n)*(K.^(2*n))) / (factorial(n));
    sigma2 = sigma2 + (((-1).^n)*(K.^(2*n + 1))) / ((2*n + 1)*factorial(n));
end
top = (2/sqrt(pi)); % two over pi

result = sqrt(pi)*expK*(1 + K*(top + (top*sigma1)) + (top*sigma2))...
         + 2*K*K*(1 + (top*sigma2))*expK;
result = result / (expK.^2);
end

