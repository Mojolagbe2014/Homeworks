%% ldlhDriver.m
%    Shows the LDLH factorization of a matrix A
%        
%       Course:     ECE 7650
%       Homework:   2
%       Sub. Date:  November 14, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

clear; clc; close all;

%% set parameters
n = [10, 100, 1000, 2000, 3000];                     % set various dimensions as a row vector
[n_siz, n_size] = size(n);                          % get the number of total elements in the n vector

for j = 1:n_size
    A = rherm(n(j));                                   % generate random Hermitian matrix of nxn dimension
    
    
%% decompose matrix A
    tic
    [l,dv] = ldlhImproved(A);                       % factorize A using ldlh algorithm
    tarr(j) = toc;                                  % store the timetaken in a row vector (tarr) for each dimensional loop of A
    d = sparse(1:n(j), 1:n(j), dv);
    proofs(j, 1) = norm(A - (l*d*ctranspose(l)));   % proof that the LDLH decomposition works
    proofs_2(j, 1:2) = [real(det(A))  prod(dv)];    % show that determinant of A is the same as product of diagonal entries D
end

%% output the results
disp(' ============ norm(A - LDLH) for the input dimensions ============');
proofs
disp(' ============ Determinant A and Product of D for the input dimensions ============');
proofs_2

data = polyfit(n, tarr, 3);
minDim = min(n);
maxDim = max(n);
datax = [minDim: (maxDim-minDim)/100000:maxDim];
datay = polyval(data, datax);
plot(datax,datay, 'r');
hold on

plot(n, tarr, 'k*', 'MarkerSize', 5);

% calculate complexity of theoritical result
n = 1:1000;
f = 2*(n.^3)/3;
f = f*(13.995e-9);

plot(n, f);
title('Complexity of LDLH Factorization');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Algorithmic Complexity', 'Actual Points ', 'Theoritical Complexity');