function [x, H, v] = fom(A, x0, b, m)
%% fom.m 
%   Implements Full Orthogonalization Method 
%       based on Modified-Gram Schmidt Process
%
%       Parameters:
%           A:      A nxn matrix
%           x0:     Initial guess
%           b:      An input non-zero nx1 vector
%           m:      Desired Krylov subspace dimension
%
%       Returns:
%            x:    Solution vector
%            H:    Upper Hesseberg matrix of dimension m+1xm
%            v:    Orthonormalized vector as basis for Km
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    r = b - A*x0;
    beta = norm(r);
    v(:, 1) = r./beta;
    H = zeros(m+1, m);

    %% main iteration
    for j = 1 : m
        w(:,j) = A*v(:, j);
        for i = 1 : j
            H(i,j) = dot(w(:,j), v(:, i));
            w(:,j) = w(:,j) - H(i,j)*v(:, i);
        end
        H(j+1, j) = norm(w(:,j));
        v(:, j+1) = w(:,j)./H(j+1, j);
    end
    
    %% fom additions to arnoldi process
    e1 = zeros(m, 1);    e1(1) = 1;                                         % obtain ecludean basis 1
    y = inv(H(1:m,1:m))*(beta*e1);                                          % H first m rows and columns of H bar
    x = x0 + v(:, 1:m)*y;                                                 
end