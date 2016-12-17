function [x, itr, err, H, v] = gmresrm(A, x0, b, m, maxItr, tol, decType)
%% gmresrm.m 
%   Implements Restarted Generalized Minimum Residual Method (GMRES) 
%       with Inner Residual Monitoring/Tracking
%       based on Modified-Gram Schmidt Process
%
%       Parameters:
%           A:      A nxn matrix
%           x0:     Initial guess
%           b:      An input non-zero nx1 vector
%           maxItr: Maximum number of expected iterations
%           m:      Desired Krylov subspace dimension
%           tol:    Error tolerance
%           decType:Decomposition type to be used (1=Givens|2=QR |else QR)
%
%       Returns:
%            x:    Solution vector
%            itr:  Total Iteration count
%            err:  Error at each Iteration count
%            H:    Upper Hesseberg matrix of dimension m+1xm
%            v:    Orthonormalized vector as basis for Km
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    x = x0;
    r = b - A*x;
    errNorm = norm(r)/norm(b);
    itr = 1;

    %% arnoldi process part based on Modified Gram Schmidt in restarting mode 
    while itr <= maxItr && errNorm > tol  
        beta = norm(r);
        v(:, 1) = r./beta;
        H = zeros(m+1, m);
        v(:, 1) = r./beta;
        for j = 1 : m
            w(:,j) = A*v(:, j);
            for i = 1 : j
                H(i,j) = dot(w(:,j), v(:, i));
                w(:,j) = w(:,j) - H(i,j)*v(:, i);
            end
            H(j+1, j) = norm(w(:,j));
            v(:, j+1) = w(:,j)./H(j+1, j);
        end

        %% gmres residual tracking part
        e1 = zeros(m+1, 1);    e1(1) = 1;    
        switch(decType)
            case 1;  [Q, R] = givens(H);
            case 2;  [Q, R] = qr(H);
            otherwise; [Q, R] = qr(H);
        end
        g = ctranspose(Q)*(beta*e1);
        y = R(1:m,1:m)\g(1:m);
        
        %% obtain the solution vector x, cal. the residual and get error norm
        x = x + v(:, 1:m)*y;
        r = b - A*x;
        errNorm = norm(r)./norm(b);
        err(itr) = errNorm;
        itr = itr + 1;
    end
    itr = itr - 1;
end