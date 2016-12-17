function [H, v] = arnoldi(A, v, m)
%% arnoldi.m 
%   Implements Residual Norm Steepest Decent 1-D Projection Method 
%       of a non-singular input matrix A 
%
%       Parameters:
%           A:      A nxn matrix
%           v:      An input non-zero nx1 vector
%           m:      Desired Krylov subspace dimension
%
%       Returns:
%            H:    Upper Hesseberg matrix
%            v:    Orthonormalized vector as basis for Km
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    v(1) = v/norm(v);
    H = zeros(m+1, m);
    
    for j = 1 : m
        w(j) = A*v(j);
        for i = 1 : j
            H(i,j) = dot(A*v(j), v(i));
            w(j) = A*v(j) - H(i,j)*v(i);
        end
        H(j+1, j) = norm(w(j));
        v(j+1) = w(j)/H(j+1, j);
    end
end