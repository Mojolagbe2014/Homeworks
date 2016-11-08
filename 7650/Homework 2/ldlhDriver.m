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
A = rherm(4);

%% factorize A using ldlh algorithm
% tic
% [l,d] = ldlh(A);
% toc
tic
[l,d] = ldlhImproved(A);
toc
%% prove that this ldlh factorization worked
proof = A - (l*d*ctranspose(l))