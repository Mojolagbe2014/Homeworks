function [x, itr, err] = sd(A, b, x0, maxItr, tol)
%% sd.m 
%   Implements Steepest Descent 1-D Projection Method 
%       of an input SPD matrix A 
%
%       Parameters:
%           A:      A symmetric positive definite matrix
%           b:      Right Hand Side
%           x0:     Initial guess
%           maxItr: Maximum number of expected iterations
%           tol:    Error tolerance
%
%       Returns:
%            x:    Solution vector
%            itr:  Iteration counter
%            err:  Error at iteration count (itr)
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    x = x0;
    itr = 1;
    r = b - A*x;
    errNorm = norm(r)/norm(b);
    p = A*r;
    
    %% main iteration block
    while itr <= maxItr && errNorm > tol
        alpha  =  dot(r, r)/dot(p, r);
        x  =  x + alpha*r;
        r = r - alpha*p;
        p = A*r;
        errNorm = norm(r)/norm(b);
        err(itr, 1) = errNorm;
        itr = itr + 1;
    end
    itr = itr - 1;
end

