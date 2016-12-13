clear; clc;
dim = 10;
k = 3;

[A] = createRankDefMatrix(dim, k);


[Zh, u, v] = aca(A, 1e-12);

%% proof that the algorithm works
norm(A - (u*v))