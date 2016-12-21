function [Q, R] = givens(A)
%% givens.m 
%   Implements Givens Rotation for computing QR
%
%       Parameters:
%           A:      A nxn matrix
%
%       Returns:
%            Q:    Unitary matrix
%            R:    Upper triangular matrix
%
%   Author: Jamiu Babatunde Mojolagbe

    %% set parameters
    [n, m] = size(A);                   % obtain the number of columns and rows of A
    R = A;                              % start with a copy of A
    Q = eye(n, n);                      % form an identity matrix
    
    %% main iteration for orthornormalizing A
    for j = 1:m                         % for ach column of A       
        for i = j + 1: n                % for each element below the main diagonal
            if R(i, j) == 0
                c = 1;
                s = 0;
            elseif R(j, j) == 0
                c = 0;
                s = conj(R(i, j))/abs(A(i, j));
            else
                c = abs(R(j, j))./sqrt((abs(R(j, j)).^2) + (abs(R(i, j)).^2));
                s = (R(j, j) /abs(R(j, j))) * (conj(R(i, j)) / sqrt((abs(R(j, j)).^2) + (abs(R(i, j)).^2)));
            end
            % Obtain Given rotation
            giv = eye(n, n);
            giv(i, i) = c;
            giv(j, j) = c;
            giv(i, j) = -s';
            giv(j, i) = s;
            
            R = giv * R;         % Apply rotation 
            Q = Q * ctranspose(giv);
        end
    end
end

