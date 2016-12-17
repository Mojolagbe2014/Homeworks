clear; close all; clc;
tarr = [0.0146152114229664;1.84716424266648;168.710732680456;1365.32622999174];
n = [10;100;500;1000];

data = polyfit(n, tarr, 3);
minDim = min(n);
maxDim = max(n);
datax = [minDim: (maxDim-minDim)/100000:maxDim];
datay = polyval(data, datax);
plot(datax,datay, 'r');
hold on

plot(n, tarr, 'k*', 'MarkerSize', 5);

n = 1:1000;
f = 2*(n.^3)/3;
f = f*(2040e-9);

plot(n, f);
title('Complexity of Cholesky Factorization');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Algorithmic Complexity', 'Actual Points ', 'Theoritical Complexity');