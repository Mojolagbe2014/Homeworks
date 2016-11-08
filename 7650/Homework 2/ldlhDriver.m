close all
clear all
clc


%A = rand(4,4) + 1i*rand(4,4);
A = rherm(25);
tic
[l,d] = ldlh(A);
toc
tic
[l,d] = ldlhImproved(A);
toc
%% prove that this ldlh factorization worked
proof = A - (l*d*ctranspose(l));