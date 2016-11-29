close all
clear all
clc

nx = 5;
ny = 5;

xmin = 0;
xmax = 1;

ymin = 0;
ymax = 1;

Tleft = 75;
Tright = 50;
Tbottom = 0;
Ttop = 100;

[A, b] = getSystemLaplaceSparse(nx,ny, xmin, xmax, ymin, ymax, Tleft, Tright, Tbottom, Ttop);

% A = randi(5, 4, 4);
% A = [1 0 0 3; 0 0 1 2; 4 0 1 0; 1 0 0 2];
p = bfs(A, 1);