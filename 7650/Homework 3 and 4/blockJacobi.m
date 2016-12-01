function [x, itr, err] = blockJacobi(A, b, blockSize, guess, maxIter, tol)
%% blockJacobi.m 
%   Implements Block Jacobi Method
%       iterative technique for solving linear algera equations
%
%       Parameters:
%           A:      A sparse matrix in compressed-row format with each row sorted
%           i:      An index of the first vertex (row) to start at
%       Returns:
%            P:     A permutation matrix
%            pi:    A permutation list based on the ordering of the vertices traversed
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters 
    [bn bm] = size(A);                                  % obtain the dimension of A
    p = bn/blockSize;                                   % obtain block matrix dimension
    itr = 1;
    err = 99999;
    x(1:bm, itr) = guess;
    
    while itr < maxIter && err > tol
        for i = 1:p
            row = i*blockSize;
            Di = A((row - blockSize + 1):row, (row - blockSize + 1):row);
            bi = b((row - blockSize + 1):row, 1);

            sigma = 0;
            for j = 1:p
                col = j*blockSize;
                xj = x((col - blockSize + 1):col, itr);
                if j ~= i
                    Aij = A((row - blockSize + 1):row, (col - blockSize + 1):col);
                    sigma = sigma + (Aij*xj);
                end
            end
            rhs = bi - sigma;
            x((row - blockSize + 1):row, itr + 1) = Di\rhs;
        end
        err = ((norm(x(:, itr+1) - x(:, itr))).^2)/((norm(x(:, itr))).^2);
        itr = itr + 1;
    end
    x = x(1:bm, itr);
end