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
n = 4;                                              % dimension of A
A = spd(n);                                         % generate random hermitian positive definite matrix A

%% factorize A using cholesky algorithm
tic
[l] = cholesky(A);
toc
%% prove that this cholesky factorization worked
proof = A - (l*ctranspose(l))