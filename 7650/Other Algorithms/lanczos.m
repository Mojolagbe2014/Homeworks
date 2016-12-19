function [H, v] = lanczos(A, v, m)
    v(:, 1) = v/norm(v);
    v0 = 0;
    B(1) = 0;
    H = zeros(m+1, m);

    for j = 1:m
        w(:, j) = A*v(:, j);
        H(j, j) = dot(w(:, j), v(:, j));
        if j > 1; w(:, j) = A*v(:, j) - B(j)*v(:, j - 1); end
        a(j,j) = dot(w(:, j), v(:, j)); 
        w(:, j) = w(:, j) - a(j,j)*v(:, j);
        B(j+1) = norm(w(:,j));
        H(j, j+1) = B(j+1);
        if B(j+1)==0; return; end
        v(:, j+1) = w(:,j)./B(j+1);
    end
    H = H + diag(diag(H,1),-1);
    H = H(1:m+1, 1:m);
end