function [q, r] = houseHolder(A)
%% houseHolder
%   Solves matrix with householder transformation technique

    [n, m] = size(A);
    I = eye(n, n);
    for j = 1:m
        a = A(:, j);
        if j > 1 
            for ii = 1 : j - 1
                if ii == 1; r(:, j) = a; end
                r(:, j) = r(:, j) - (1 + omega(ii)) * w(:, ii)* (w(:, ii)' * r(:, j));
            end 
        else
            r(:, 1) = a;
        end
        %create z
        for k = 1:n
            beta = exp(i.*angle(r(k, j))) .* norm(r(k:end, j));
            if k < j; z(k, 1) = 0;
            elseif k == j; z(k, 1) = r(k, j) + beta;
            elseif k > j; z(k, 1) = r(k, j);
            end
        end
        
        w(:, j) = z/norm(z);                      % get w vector
        omega(j) = (r(:, j)'*w(:, j)) / (w(:, j)'*r(:, j));            % get omega 
        
        r(:, j) = r(:, j) - (1 + omega(j)) * w(:, j) * (w(:, j)' * r(:, j));
        q(:, j) = I(:, j) - (1 + omega(j)) * w(:, j)* (w(:, j)' * I(:, j));
        
        if j > 1
            for ii = j - 1: -1: 1
                q(:, j) = q(:, j) - (1 + omega(ii)) * w(:, ii)* (w(:, ii)' * q(:, j));
            end
        end
        
    end
end