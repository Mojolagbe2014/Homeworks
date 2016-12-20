%% testHouseHolder.m
%    Test the implementational function 
%       of Householder Reflection QR Decomposition
%        
%       Course:     ECE 7650
%       Homework:   1
%       Sub. Date:  October 26, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

clear; clc; close all;

%% set parameters
n = [10, 100];                    % set various dimensions as a row vector
[n_siz, n_size] = size(n);                          % get the number of total elements in the n vector

for j = 1:n_size
    A = exp(i * pi * randn(n(j), n(j)));            % create complex matrix nxn
    
    
%% decompose matrix A
    tic
    [q, r] = houseHolder(A);                        % decompose matrix A using modified Gram-Schmidt method
    tarr(j) = toc;                                  % store the timetaken in a row vector (tarr) for each dimensional loop of A
    proofs(j, 1) = norm(q*r - A);                   % proof that the QR decomposition works
end

%% output the results
disp(' ============ norm(Q*R - A) for the input dimensions ============');
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
n = 1:3000;
f = 4*(n.^3) + 11*(n.^2) + 12*(n) + 3;
f = f*(13.995e-9);

plot(n, f);
title('Complexity of Modified Gram Schmidt');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Algorithmic Complexity', 'Actual Points ', 'Theoritical Complexity');