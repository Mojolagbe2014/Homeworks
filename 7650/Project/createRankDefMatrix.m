function [A] = createRankDefMatrix(dim, rk)
%% createRankDefMatrix.m
%   Creates a random rank deficient matrix
%
%       Parameter:
%           dim:    The desired dimension of the matrix to be created
%           rk:     Rank of the desired matrix must be less than dim
%       
%       Returns:
%           A:      Rank defiecient matrix or full rank matrix if dim=rk
%
%       Author: Jamiu Babatunde Mojolagbe

    assert(rk <= dim, 'Rank cannot be greater than matrix dimension !!!');  % assert rk <= matrix dimension
    A = zeros(dim);                                                         
    for i = 1:rk, A = A + randn(dim,1) * randn(1,dim); end                  % create the matrix
end