function [x, H, v] = gmres(A, x0, b, m, decType)
%% gmres.m 
%   Implements Generalized Minimum Residual Mesthod (GMRES) 
%       based on Modified-Gram Schmidt Process
%
%       Parameters:
%           A:      A nxn matrix
%           x0:     Initial guess
%           b:      An input non-zero nx1 vector
%           m:      Desired Krylov subspace dimension
%           decType:Decomposition type to be used (1=Givens | 2=QR | else ==)
%
%       Returns:
%            x:    Solution vector
%            H:    Upper Hesseberg matrix of dimension m+1xm
%            v:    Orthonormalized vector as basis for Km
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    r = b - A*x0;
    beta = norm(r);
    v(:, 1) = r./beta;
    H = zeros(m+1, m);

    %% arnoldi process part based on Modified Gram Schmidt 
    for j = 1 : m
        w(:,j) = A*v(:, j);
        for i = 1 : j
            H(i,j) = dot(w(:,j), v(:, i));
            w(:,j) = w(:,j) - H(i,j)*v(:, i);
        end
        H(j+1, j) = norm(w(:,j));
        v(:, j+1) = w(:,j)./H(j+1, j);
    end
    
    %% gmres additions to arnoldi process
    e1 = zeros(m+1, 1);    e1(1) = 1;                                         % obtain ecludean basis 1
    switch(decType)
        case 1;  [Q, R] = givens(H);
        case 2;  [Q, R] = qr(H, 0);
        otherwise; [Q, R] = qr(H, 0);
    end
    y = R\(ctranspose(Q)*(beta*e1));                                             
    x = x0 + v(:, 1:m)*y;                                                 
end