%% choleskyDriver.m
%    Shows the cholesky factorization of 
%       a random hermitian/symmetric positive definite matrix
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
n = [10, 100, 500, 1000];                           % set various dimensions as a row vector
[n_siz, n_size] = size(n);                          % get the number of total elements in the n vector

for j = 1:n_size
    A = spd(n(j));                                   % generate random Hermitian positive definite matrix of nxn dimension
    
    
%% decompose matrix A
    tic
    [l] = cholesky(A);                              % factorize A using cholesky algorithm
    tarr(j) = toc;                                  % store the timetaken in a row vector (tarr) for each dimensional loop of A
    
    proofs(j, 1) = norm(A - (l*ctranspose(l)));     % proof that the cholesky decomposition works
end

%% output the results
disp(' ============ norm(A - LLH) for the input dimensions ============');
proofs

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
f = f*(2040e-9);

plot(n, f);
title('Complexity of Cholesky Factorization');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Algorithmic Complexity', 'Actual Points ', 'Theoritical Complexity');