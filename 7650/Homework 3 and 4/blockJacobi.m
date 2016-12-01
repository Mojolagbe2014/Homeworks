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
    [bn bm] = size(A);                                                      % obtain the dimension of A
    p = bn/blockSize;                                                       % obtain block matrix dimension
    itr = 1;                                                                % initialize iteration counter
    err = 99999;                                                            % set error to a certain maximum
    x(1:bm, itr) = guess;                                                   % set solution to the initial guess
    
    %% solve the matrix A using iterative Jacobi 
    while itr < maxIter && err > tol
        for i = 1:p
            row = i*blockSize;                                              % cal. the row count stop value
            Di = A((row - blockSize + 1):row, (row - blockSize + 1):row);   % get the diagonal block D
            bi = b((row - blockSize + 1):row, 1);                           % obtain the corresponding block to this equation
            
            sigma = 0;
            for j = 1:p
                col = j*blockSize;                                          % get the col count stop value
                xj = x((col - blockSize + 1):col, itr);                     % obtain the corresponding x values to the current block
                if j ~= i
                    Aij = A((row - blockSize + 1):row, (col - blockSize + 1):col);
                    sigma = sigma + (Aij*xj);
                end
            end
            rhs = bi - sigma;                                               % obtain the rhs 
            x((row - blockSize + 1):row, itr + 1) = Di\rhs;                 % solve the equation with backslash operator
        end
        err = ((norm(x(:, itr+1) - x(:, itr))).^2)/((norm(x(:, itr))).^2);  % calculate the error norm
        itr = itr + 1;                                                      % increment the counter
    end
    x = x(1:bm, itr);                                                       % return last value of the last iteration
end