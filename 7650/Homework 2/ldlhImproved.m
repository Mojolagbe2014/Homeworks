function [l, d] = ldlhImproved(A)
%% ldlh.m 
%   Implements LDLH factorization of an
%       input complex A 
%       return 
%           l - Lower triangular matrix
%           d - Diagonal entries as a column vector
%
%   Author: Jamiu Mojolagbe


    %% obtain the dimension of A and ensure ncols==nrows
    [n, m] = size(A);                                   % obtain the number of rows and cols of A
    assert(n==m, 'Matrix A must be square!');           % make sure matrix A is a square on i.e ncols == nrows 
    
    %% set needed parameters
    l = eye(n, n);                                      % initialize resulting lower triangular matrix
    d = zeros(1, n);                                    % resulting diagonal entries as column vector
    %% factorize A to ld
    for i = 1:n                                         % for each row
        for j = 1:i-1                                   % lower triangular part along row
            l(i,j) = A(i,j);                            % initialize lij and calculate it
            for k = 1:j-1
                l(i, j) = l(i, j) - l(i,k)*ctranspose(l(j,k))*d(k);
            end
            l(i, j) = l(i, j)/d(j);
        end
        d(i) = A(i, i);
        for k = 1:i-1
            d(i) = d(i) - l(i,k)*ctranspose(l(i,k))*d(k);
        end
    end
%     d = sparse(1:n, 1:n, d);                            % return d as a sparse matrix
end

