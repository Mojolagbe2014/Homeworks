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
n = [10, 100, 1000, 2000, 3000];                    % set various dimensions as a row vector
[n_siz, n_size] = size(n);                          % get the number of total elements in the n vector

for j = 1:n_size
    A = exp(i * pi * randn(n(j), n(j)));            % create complex matrix nxn
    
    
%% decompose matrix A
    tic
    [q, r] = houseHolder(A);                        % decompose matrix A using modified Gram-Schmidt method
    tarr(j) = toc                                   % store the timetaken in a row vector (tarr) for each dimensional loop of A

end

%% output the results
plot(n, tarr)
title('Computational Time (Householder QR)');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');