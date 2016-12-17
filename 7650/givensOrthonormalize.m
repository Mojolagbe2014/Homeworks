function [Q, R] = givensOrthonormalize(A)
%% GIVENSORTHONORMALIZE Orthonormalize a matrix (set of vectors)
%   Using Givens orthonormalization approach
%
%       Author: Jamiu Mojolagbe


    [n, m] = size(A);                   % obtain the number of columns and rows of A
    R = A;                              % start with a copy of A
    Q = eye(n, n);                      % form an identity matrix
    
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
            givens = eye(n, n);
            givens(i, i) = c;
            givens(j, j) = c;
            givens(i, j) = -s';
            givens(j, i) = s;
            
            R = givens * R;         % Apply rotation 
            Q = Q * ctranspose(givens);
        end
    end
end

