clear; close all; clc;
tarr = [0.0035685425106160;1.56746074271622;173.413785821126;1388.00895329618];
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
title('Complexity of LDLH Factorization');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Algorithmic Complexity', 'Actual Points ', 'Theoritical Complexity');