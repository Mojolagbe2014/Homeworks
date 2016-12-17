function [Zh, u, v, I, J, err1] = aca(Z, tol)
%% aca2.m 
%   Implements the Adaptive Cross Approximation algorithm 
%
%       Parameters:
%           Z:      A rank deficient/full matrix 
%           tol:    A given error tolerance
%
%       Returns:
%            Zh:    Error at each iterations (Zhi hat)
%            u:     Approximate column vector with dimension nxr
%            v:     Approximate row vector with dimension rxm
%            I:     Row index 
%            J:     Column index
%            err1:  norm of u and v at each iterations
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    [n, m] = size(Z);                                                       % obtain the dimension of A
    R = zeros(n, m);
    I(1) = 1;                                                               % Initialize the 1st row index
    Zh = 0;
    R(I(1), :) = Z(I(1),:);                                                 % Initialize the 1st row of the approximate error matrix
    [~, J(1)] = max(abs(Z(I(1), :)));                                             % choose the 1st column index J1
    v = R(I(1), :)./R(I(1), J(1));
    R(:, J(1)) = Z(:, J(1));                                                % Initialize the 1st column of the approximate error matrix
    u = R(:, J(1));
    Zh = sqrt((norm(Zh,'fro').^2) + ((norm(u,'fro').^2)* (norm(v,'fro').^2)));
    % choose the 2nd row index I2
    a =  abs(Z(:, J(1)));                                                        % create temporary vector A                            
    val = max((a(~ismember(a,a(I)))));
    I(length(I)+1)  = find(a == val);
    
    for k = 2:min(n,m)
        sigma = 0;
        for l = 1:k-1
            sigma =sigma + u(I(k),l).*v(l, :);
        end
        R(I(k), :) = Z(I(k), :) - sigma;
        a =  abs(Z(I(k), :));                                                        % create temporary vector A                            
        val = max((a(~ismember(a,a(J)))));
        J(k)  = find(a == val);
        v(k, :) = R(I(k), :)/R(I(k), J(k));
        % Update (Jk )th column of the approximate error matrix
        sigma = 0;
        for l = 1:k-1
            sigma =sigma + v(l,J(k))*u(:,l);
        end
        R(:, J(k)) = Z(:, J(k)) - sigma;
        u(:, k) = R(:, J(k));
        sigma = 0;
        for j = 1:k-1
            sigma = sigma + (abs(u(:, j)'*u(:,k))*abs(v(j, :)*v(k,:)'));
        end
        Zh(k) = sqrt((norm(Zh(k-1),'fro').^2) + (2*sigma) + ((norm(u(:,k),'fro').^2)* (norm(v(k,:),'fro').^2)));
        err1(k) = (norm(u(:,k),'fro')*norm(v(k, :),'fro'));
        err2 = tol*Zh(k);
        if  err1(k) <= err2; 
            u = u(:, 1:k-1);
            v = v(1:k-1, :);
            return; 
        end
        a =  abs(Z(:, J(k)));                                                        % create temporary vector A                            
        val = max((a(~ismember(a,a(I)))));
        if k < min(n,m)
        I(k+1)  = find(a == val);
        end
    end
end