close all
clear all
clc

nx = 100;
ny = 100;

xmin = 0;
xmax = 1;

ymin = 0;
ymax = 1;

Tleft = 75;
Tright = 50;
Tbottom = 0;
Ttop = 100;

[A, b] = getSystemLaplaceSparse(nx,ny, xmin, xmax, ymin, ymax, Tleft, Tright, Tbottom, Ttop);

[L,U] = lu(A);
solution = U\(L\b);

plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, solution, 1000, 'No Permutation LU Solution');