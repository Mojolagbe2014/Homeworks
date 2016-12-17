function [x, itr, err] = minres(A, b, x0, maxItr, tol)
%% minres.m 
%   Implements Minimum Residual Iteration 1-D Projection Method 
%       of an input (S)PD matrix A 
%
%       Parameters:
%           A:      A positive definite matrix
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
        alpha  =  dot(r, p)/dot(p, p);
        x  =  x + alpha*r;
        r = r - alpha*p;
        p = A*r;
        errNorm = norm(r)/norm(b);
        err(itr, 1) = errNorm;
        itr = itr + 1;
    end
    itr = itr - 1;
end

