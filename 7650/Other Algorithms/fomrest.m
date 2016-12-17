function [x, H, v, j] = fomrest(A, x0, b, m, tol)
%% fomrest.m 
%   Implements Full Orthogonalization Method 
%       with Inner Residual Monitoring/Tracking
%       based on Modified-Gram Schmidt Process
%
%       Parameters:
%           A:      A nxn matrix
%           x0:     Initial guess
%           b:      An input non-zero nx1 vector
%           m:      Desired Krylov subspace dimension
%           tol:    Error tolerance
%
%       Returns:
%            x:    Solution vector
%            H:    Upper Hesseberg matrix of dimension m+1xm
%            v:    Orthonormalized vector as basis for Km
%            j:    value of j at which it converges to the error tolerance
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    r = b - A*x0;
    beta = norm(r);
    v(:, 1) = r./beta;
    H = zeros(m+1, m);

    %% arnoldi process part based on Modified Gram Schmidt with inner residual tracking 
    for j = 1 : m
        w(:,j) = A*v(:, j);
        for i = 1 : j
            H(i,j) = dot(w(:,j), v(:, i));
            w(:,j) = w(:,j) - H(i,j)*v(:, i);
        end
        H(j+1, j) = norm(w(:,j));
        v(:, j+1) = w(:,j)./H(j+1, j);
        % error monitoring part
        e1 = zeros(j, 1);    e1(1) = 1;                                         % obtain ecludean basis 1
        ej = zeros(j, 1);    ej(j) = 1;                                         % obtain ecludean basis 1
        y = (H(1:j,1:j))\(beta*e1);                                          % H first m rows and columns of H bar
        err = H(j+1, j)*(abs(dot(y, ej))./norm(b))
        if err < tol; break; end
    end
    
    %% fom additions to arnoldi process
    x = x0 + v(:, 1:j)*y;                                                 
end