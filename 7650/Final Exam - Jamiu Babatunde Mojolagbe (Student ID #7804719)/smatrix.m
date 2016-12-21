function A = smatrix(n)
%% smatrix.m
%   Generate symmetric matrix
%       Input:   n - dimension of the resulting matrix
%       Returns: A - resulting symmetric matrix
%       Author: Jamiu Mojolagbe

    %% obtain Symmetric matrix
    A = randn(n, n);         % generate a random n x n matrix
    A = 0.5*(A+A');
    A = A + n*eye(n);
end