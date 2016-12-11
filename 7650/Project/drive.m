clear; clc;
dim = 10;
k = 6;

[A] = createRankDefMatrix(dim, k);


[Zh, u, v, I, J, err1] = aca(A, 1e-6, k)