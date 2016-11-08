function [l] = cholesky(A)
%% cholesky.m 
%   Implements Cholesky factorization of an
%       input complex A 
%       return 
%           l - Lower triangular matrix
%           d - Diagonal matrix or entries
%
%   Author: Jamiu Mojolagbe


    %% obtain the dimension of A and ensure ncols==nrows
    [n, m] = size(A);                                   % obtain the number of rows and cols of A
    assert(n==m, 'Matrix A must be square!');           % make sure matrix A is a square on i.e ncols == nrows 
    
    %% set needed parameters
    l = eye(n, n);                                      % initialize resulting lower triangular matrix
    
    for i = 1:n                                         % for each row
        for j = 1:i-1                                   % lower triangular part along row
            l(i,j) = A(i,j);                            % initialize lij and calculate it
            for k = 1:j-1
                l(i, j) = l(i, j) - l(i,k)*ctranspose(l(j, k));
            end
            l(i, j) = l(i, j)/l(j, j);
        end
        l(i, i) = A(i, i);
        for k = 1:i-1
            l(i, i) = l(i, i) - l(i,k)*ctranspose(l(i,k));
        end
        l(i, i) = sqrt(l(i, i));
    end
end

