function [x, itr, err] = rnsd(A, b, x0, maxItr, tol)
%% rnsd.m 
%   Implements Residual Norm Steepest Decent 1-D Projection Method 
%       of a non-singular input matrix A 
%
%       Parameters:
%           A:      A non-singular matrix
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
    
    %% main iteration block
    while itr <= maxItr && errNorm > tol
        v = A'*r;
        t = A*v;
        alpha  =  norm(v).^2/norm(t).^2;
        x  =  x + alpha*v;
        r = r - alpha*t;
        errNorm = norm(r)/norm(b);
        err(itr, 1) = errNorm;
        itr = itr + 1;
    end
    itr = itr - 1;
end