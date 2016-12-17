clear; close all; clc;
tarr = [0.00579037299873811;1.39526137488197;169.959223738156;1376.18212587115];
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
f = f*(2078e-9);

plot(n, f);
title('Complexity of LDLH Factorization (Improved)');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Algorithmic Complexity', 'Actual Points ', 'Theoritical Complexity');