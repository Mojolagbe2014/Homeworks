function [x, itr, itri, err, H, v] = gmresrestart(A, x0, b, m, maxItr, tol)
%% gmresrestart.m 
%   Implements Restarted Generalized Minimum Residual Method (GMRES) 
%       with Outer Residual Monitoring/Tracking and QR by Givens
%       with Arnoldi process based on Modified-Gram Schmidt Process
%
%       Parameters:
%           A:      A nxn matrix
%           x0:     Initial guess
%           b:      An input non-zero nx1 vector
%           maxItr: Maximum number of expected iterations
%           m:      Desired Krylov subspace dimension
%           tol:    Error tolerance
%
%       Returns:
%            x:    Solution vector
%            itr:  Total Outer Iteration count
%            itri: Total Inner Iteration count of most recent outer loop
%            err:  Error at each Iteration count
%            H:    Upper Hesseberg matrix of dimension m+1xm
%            v:    Orthonormalized vector as basis for Km
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    x = x0;
    r = b - A*x;
    
    %% display header for the error printing at each outer iteration
    disp('===============   ERROR AT EACH OUTER ITERATION =================');
    
    %% arnoldi process part based on Modified Gram Schmidt in restarting mode 
    for itr = 1: maxItr 
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
        [Q, R] = givens(H);
        g = ctranspose(Q)*(beta*e1);
        y = R(1:m,1:m)\g(1:m);
        
        %% obtain the solution vector x, cal. the residual and get error norm
        x = x + v(:, 1:m)*y;
        r = b - A*x;
        err(itr) = norm(r)./norm(b);
        disp(['Error at outer iteration ', num2str(itr), ': ', num2str(err(itr))]);
        % if error < tolerance quit and return the return parameters
        if err(itr) < tol; itri = j; return; end
    end
end