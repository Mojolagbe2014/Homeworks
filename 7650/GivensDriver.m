close all
clear all
clc


A = rand(5,5) + 1i*rand(5,5);

[q,r] = givensOrthonormalize(A);