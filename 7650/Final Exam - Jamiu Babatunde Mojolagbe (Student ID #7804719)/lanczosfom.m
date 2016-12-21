function [x, j, err, v] = lanczosfom(A, x0, b, m, tol)
%% lanczosfom.m 
%   Implements Lanczos form of FOM with Tm = LmUm
%       With residual monitoring/tracking
%       [No pivoting is employed]
%
%       Parameters:
%           A:      A nxn matrix
%           x0:     Initial guess
%           b:      An input non-zero nx1 vector
%           m:      Desired Krylov subspace dimension
%           tol:    Error tolerance
%
%       Returns:
%            x:    Solution vector
%            j:    Total Iteration count
%            err:  Error at each Iteration count
%            v:    Orthonormalized vector as basis for Km
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    r = b - A*x0;                                                           % obtain the residual
    B = norm(r);                                                            % cal. beta
    E = B;                                                                  % set tsi to beta
    v(:, 1) = r./B;                                                         % normalize the residual and set it as first orthonormal vector of Vm
    lambda = 0;                                                             % set lamda to zero
    B(1)=0; 
    p(:,1) = zeros(length(x0), 1);                                          % initial pm to zero vector of length chosen guess x0
                                                                   
    
    %% lanczos iterations with LmUm=Tm 
    for j = 1:m
        w(:, j) = A*v(:, j);                              
        a(j) = dot(w(:, j), v(:, j));  
        % remove previous projections if j > 1
        if j > 1;
            w(:, j) = A*v(:, j) - B(j)*v(:, j - 1);
            lambda(j) = B(j)/n(j-1); 
            E(:, j) = -lambda(j)*E(:, j-1);     
        end
        n(j) = a(j) - lambda(j)*B(j);
        % matlab isn't zero based, remove zero index part (they are zero)
        if j == 1; 
            p(:,j) = (1/n(j))*(v(:, j)); 
            x(:, j) = x0 + E(:, j)*p(:, j);
        else
            p(:,j) = (1/n(j))*(v(:, j) - B(j)*p(:, j-1)); 
            x = x + E(:, j)*p(:, j);
        end
        
        % calculate the error
        r = b - A*x;
        errNorm = norm(r)./norm(b);
        err(j) = errNorm;
        if errNorm < tol; break; end
        
        w(:, j) = w(:,j) - a(j)*v(:, j);
        B(j+1) = norm(w(:, j));
        v(:, j+1) = w(:, j)./B(j+1);
    end   
end