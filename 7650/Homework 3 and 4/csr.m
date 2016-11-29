function [IA, JA] = csr(A)
%% csr.m 
%   Implements Compress sparse row 
%       of an input matrix A 
%
%       Parameters:
%           A:      A matrix
%           retA:   0|1 value corresponding to returning A as a vector
%
%       Returns:
%            IA:    Row indices in CSR
%            JA:    Column indices
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    [n, m] = size(A); 
    IA = ones(1, n+1);
    
    %% loop through the rows and compile the CSR parameters
    for i = 1:n; 
        nzr = nnz(A(i ,:));
        IA(i+1) = nzr;  
        if i == 1;  JA = [find(A(i ,:))];
        else JA = [JA find(A(i ,:))];
        end
    end
    IA = cumsum(IA);
end