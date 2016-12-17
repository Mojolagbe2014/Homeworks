clear; clc;
tarr = [0.0250;0.1896;74.6380;465.0581;1495.8253;];
n = [10;100;1000;2000;3000];

data = polyfit(n, tarr, 3);
minDim = min(n);
maxDim = max(n);
datax = [minDim: (maxDim-minDim)/100000:maxDim];
datay = polyval(data, datax);
plot(datax,datay, 'r');
hold on

plot(n, tarr, 'k*', 'MarkerSize', 5);


n = 1:3000;
f = 4*(n.^3) + 11*(n.^2) + 12*(n) + 3;
f = f*(13.995e-9);
plot(n, f);
title('Complexity of Householder QR');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Algorithmic Complexity (Fitting Curve)', 'Actual Points ', 'Theoritical Complexity');