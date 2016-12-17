clear; clc;
dim = 10;
k = 10;
tolerance = 1e-6;

[A] = createRankDefMatrix(dim, k);
%A = rand(dim);

tic
[Zh2, u2, v2] = aca(A, tolerance);
toc

tic
[Zh, u, v] = aca2(A, tolerance);
toc


[U,S,V] = svd(A);

singular_values = diag(S);
Sprime = singular_values(singular_values > tolerance*singular_values(1));  %Check this condition 
ksvd = length(Sprime);
svd_error = singular_values(min(dim,ksvd+1))
Sprime = diag(Sprime);
Uprime = U(:,1:ksvd);
Vprime = V(:,1:ksvd);
Uprime = Uprime*Sprime;

Aaca = u2*v2;
Asvd = Uprime*Vprime';

%% proof that the algorithm works
norm(A - (u2*v2))
norm(Asvd - A)

