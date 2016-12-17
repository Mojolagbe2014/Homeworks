function [H, v] = arnoldi(A, v, m)
%% arnoldi.m 
%   Implements Arnoldi Orthonormalization 
%       based on Modified-Gram Schmidt Process
%
%       Parameters:
%           A:      A nxn matrix
%           v:      An input non-zero nx1 vector
%           m:      Desired Krylov subspace dimension
%
%       Returns:
%            H:    Upper Hesseberg matrix of dimension m+1xm
%            v:    Orthonormalized vector as basis for Km
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    v(:, 1) = v/norm(v);
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
end