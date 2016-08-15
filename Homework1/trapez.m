function [int, errOrd] = trapez(f, a, b, Nt)
% trapez(f, a, b, Nt)  Calculate the integral of a function using 
%   trapezoidal algorithm for 1 - Dimensional problem
%
%       [int, errOrd] = trapez(f, a, b, Nt)
%
%           f:          Handle to the test function
%           a:          Lower bound of the integration
%           b:          Upper bound of the integration
%           Nt:         Number of points to be created/resolution
%
%           returns:
%           int:        Integral of the curve
%           errOrd:     Order of error (h^3) assuming f''=1
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
for j = 1:(Nt-1)
   sigmal = sigmal + f(a+(j*h));
end


%% calculate the integral of the curve 
int = ((f(a)/2) + (f(b)/2) + sigmal)*h;
errOrd = h.^3; % assuming second derivative of f''(x) = 1

end

