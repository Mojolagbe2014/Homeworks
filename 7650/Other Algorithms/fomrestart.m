function [x, itr, err, H, v] = fomrestart(A, x0, b, m, maxItr, tol)
%% fomrestart.m 
%   Implements Restarted Full Orthogonalization Method 
%       based on Modified-Gram Schmidt Process
%
%       Parameters:
%           A:      A nxn matrix
%           x0:     Initial guess
%           b:      An input non-zero nx1 vector
%           maxItr: Maximum number of expected iterations
%           m:      Desired Krylov subspace dimension
%           tol:    Error tolerance
%
%       Returns:
%            x:    Solution vector
%            H:    Upper Hesseberg matrix of dimension m+1xm
%            v:    Orthonormalized vector as basis for Km
%            itr:  Iteration counter
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    x = x0;
    r = b - A*x;
    errNorm = norm(r)/norm(b);
    itr = 1;

    %% arnoldi process part based on Modified Gram Schmidt in restarting mode 
    while itr < maxItr && errNorm > tol  
        beta = norm(r);
        v(:, 1) = r./beta;
        H = zeros(m+1, m);
        v(:, 1) = r./beta;
        for j = 1 : m
            w(:,j) = A*v(:, j);
            for i = 1 : j
                H(i,j) = dot(w(:,j), v(:, i));
                w(:,j) = w(:,j) - H(i,j)*v(:, i);
            end
            H(j+1, j) = norm(w(:,j));
            v(:, j+1) = w(:,j)./H(j+1, j);
        end

        %% obtain the solution vector x
        e1 = zeros(m, 1);    e1(1) = 1;                                     % obtain ecludean basis 1
        y = (H(1:m,1:m))\(beta*e1);                                         % H first m rows and columns of H bar
        x = x + v(:, 1:m)*y;
        r = b - A*x;
        errNorm = norm(r)./norm(b);
        err(itr) = errNorm;
        itr = itr + 1;
    end
    itr = itr - 1;
end