function [r, n, m] = getLowestDegree(A)
%% getLowestDegree.m 
%   Get index of the row with lowest degree of freedom, i. e, neighbors
%
%       Parameters:
%           A:      A sparse matrix in compressed-row format with each row sorted
%       Returns:
%            r:     Index of the row with lowest degree of freedom
%            n:     Number of rows in A
%            m:     Number of columns in A
%
%   Author: Jamiu Babatunde Mojolagbe
    
    %% set parameters
    [n, m] = size(A);                                   % obtain the number of rows and cols of A
    
    %% loop through the rows of A and get the non-zeros
    for i = 1:n
        nz(i) = nnz(A(i, :));
    end
    
    r = find(nz(:) == min(nz));
end

