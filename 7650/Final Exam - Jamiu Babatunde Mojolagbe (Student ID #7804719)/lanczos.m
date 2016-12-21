function [H, v] = lanczos(A, v, m)
%% arnoldi.m 
%   Implements Lanczos Orthonormalization 
%       for symmetric/Hermitian matrix
%
%       Parameters:
%           A:      A nxn symmetric/Hermitian matrix
%           v:      An input non-zero nx1 vector
%           m:      Desired Krylov subspace dimension
%
%       Returns:
%            H:    Symmetric tridiagonal matrix of dimension m+1xm
%            v:    Orthonormalized vector as basis for Km
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    v(:, 1) = v/norm(v);                                                    % normalize the chosen vector into unit vector
    B(1) = 0;                                                               % initialize beta
    H = zeros(m+1, m);                                                      % initialize symmetric tridiagonal matrix

    %% lanczos iterations
    for j = 1:m
        w(:, j) = A*v(:, j);                                                % v0 is not used as product of B(1)*v0 ==0, therefore it is omitted in the parameters
        H(j, j) = dot(w(:, j), v(:, j));                                    % set entry for H(j,j) of tridiagonal matrix H
        if j > 1; w(:, j) = A*v(:, j) - B(j)*v(:, j - 1); end               % obtain previous projections if j > 1
        a(j,j) = dot(w(:, j), v(:, j)); 
        w(:, j) = w(:, j) - a(j,j)*v(:, j);                                 % remove previous projections
        B(j+1) = norm(w(:,j));
        H(j, j+1) = B(j+1);
        if B(j+1)==0; return; end                                           % if B==0, do not break down just quick the function and return parameters
        v(:, j+1) = w(:,j)./B(j+1);                                         % set the next orthogonal vector
    end
    
    %% obtain the symmetric triadiagonal matrix H
    H = H + diag(diag(H,1),-1);
    H = H(1:m+1, 1:m);
end