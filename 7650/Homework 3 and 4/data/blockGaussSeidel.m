function [x, itr, err] = blockGaussSeidel(A, b, blockSize, guess, maxIter, tol)
%% blockGaussSeidel.m 
%   Implements Block Gauss-Seidel Method
%       iterative technique for solving linear algera equations
%
%       Parameters:
%           A:          A matrix
%           b:          The right hand side of A
%           blockSize:  Minimum dimension/size of each block that A is splitted into
%           guess:      Initial guess
%           maxIter:    Maximum number of iterations expected
%           tol:        Expected minimum relative error 
%       Returns:
%            x:     	Solution vector 
%            itr:    	Number of iterations done to reach the solution
%            err:       Relative error norm 
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters 
    [bn, bm] = size(A);                                                     % obtain the dimension of A
    p = bn/blockSize;                                                       % obtain block matrix dimension
    itr = 1;                                                                % initialize iteration counter
    errNorm = 99999;                                                        % set error to a certain maximum
    x(1:bm, itr) = guess;                                                   % set solution to the initial guess
    assert(blockSize <= bn, 'Error! Required block size is greater than A');% confirm blockSize is not greater than A itself
    
    %% solve the matrix A using iterative Gauss-Siedel 
    while itr < maxIter && errNorm > tol
        for i = 1:p
            % cal. the row count stop value
            % and avoid overlapping of blocks
            if i == floor(p) && mod(bn, blockSize) ~=0
                rowe = bn;
            else
                rowe = i*blockSize;
            end  
            row = i*blockSize;                                              % cal. the row count stop value
            Di = A((row - blockSize + 1):rowe, (row - blockSize + 1):rowe); % get the diagonal block D
            bi = b((row - blockSize + 1):rowe, 1);                          % obtain the corresponding block to this equation
            
            sigma1 = 0;
            for j = 1:i-1
                % get the col count stop value
                % and avoid overlapping of blocks
                col = j*blockSize;
                if j == floor(p) && mod(bn, blockSize) ~=0; cole = bm;
                else cole = j*blockSize;
                end                                        
                xj = x((col - blockSize + 1):cole, itr+1);                  % obtain the corresponding x(k+1) values to the current block
                Aij = A((row - blockSize + 1):rowe, (col - blockSize + 1):cole);
                sigma1 = sigma1 + (Aij*xj);
            end
            sigma2 = 0;
            for j = i+1:p
                % get the col count stop value
                % and avoid overlapping of blocks
                col = j*blockSize;
                if j == floor(p) && mod(bn, blockSize) ~=0; cole = bm;
                else cole = j*blockSize;
                end                                        
                xj = x((col - blockSize + 1):cole, itr);                    % obtain the corresponding x(k+1) values to the current block
                Aij = A((row - blockSize + 1):rowe, (col - blockSize + 1):cole);
                sigma2 = sigma2 + (Aij*xj);
            end
            rhs = bi - sigma1 - sigma2;                                     % obtain the rhs 
            x((row - blockSize + 1):rowe, itr + 1) = Di\rhs;                % solve the equation with backslash operator
        end
        %err = ((norm(x(:, itr+1) - x(:, itr))).^2)/((norm(x(:, itr))).^2); % calculate the error norm
        errNorm = ((norm((A*x(:, itr+1)) - b)))/((norm(b)));                % calculate the error norm
        err(itr, 1) = errNorm;
        itr = itr + 1;                                                      % increment the counter
    end
    itr = itr - 1;                                                          % decrement the iteration by 1
end