function [q, r] = houseHolder(r)
%% houseHolder
%   Solves matrix with householder transformation technique
% 
%   Input: r (a matrix)
%   Returns: q, r (q is a set of orthonormal vectors and r is upper
%            triangular matrix)
%       
%       Author: Jamiu Mojolagbe

    [n, m] = size(r);
    I = eye(n, n);
    for j = 1:m
        for ii = 1 : j - 1
            r(:, ii) = r(:, ii) - (1 + omega(ii)) * w(:, ii)* dot(w(:, ii), r(:, ii));
        end 
        %create z
        for k = 1:n
            if k < j; z(k, 1) = 0;
            elseif k == j; z(k, 1) = r(k, j) + exp(i.*angle(r(k, j))) .* norm(r(k:end, j));
            elseif k > j; z(k, 1) = r(k, j);
            end
        end        
        w(:, j) = z/norm(z);                                              % get w vector
        omega(j) = dot(r(:, j), w(:, j)) / dot(w(:, j), r(:, j));            % get omega 
        
        r(:, j) = r(:, j) - (1 + omega(j)) * w(:, j)* dot(w(:, j), r(:, j));
        q(:, j) = I(:, j) - (1 + omega(j)) * w(:, j)* dot(w(:, j), I(:, j));
        
        for ii = j - 1: -1: 1
            q(:, j) = q(:, j) - (1 + omega(ii)) * w(:, ii)* dot(w(:, ii), q(:, j));
        end
    end
end