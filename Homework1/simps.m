function [int, errOrd] = simps(f, a, b, Nt)
% simps(f, a, b, Nt)  Calculate the integral of a function using 
%   Simpson's algorithm for 1 - Dimensional problem
%
%       [int, errOrd] = simps(f, a, b, Nt)
%
%           f:          Handle to the test function
%           a:          Lower bound of the integration
%           b:          Upper bound of the integration
%           Nt:         Number of points to be created/resolution
%
%           returns:
%           int:        Integral of the curve
%           errOrd:     Order of error (h^5) assuming f''''=1
%
%
%                       Author: Jamiu Mojolagbe
%

%% set parameters
sigmal = 0;     % summation of remainder part of the curve apart from 
                % the start(lower bound) & stop(upper bound) points

%% tabulate function
x = linspace(a, b, Nt);

% obtain the distance between two successive points
h = x(2) - x(1);


%% calculate the summation of all other points 
%   apart from the first and last
for j = 1:(Nt/2)
   sigmal = sigmal + f(a+((2*j)-2).*h) + (4.*f(a+((2*j)-1).*h))+ (f(a+(2*j).*h));
end


%% calculate the integral of the curve 
int = ((h/3).*sigmal);
errOrd = h.^5; % assuming fourth derivative of f(x) = 1

end

