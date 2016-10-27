clear; clc;
tarr = [0.0124;0.0935;23.7213;175.4073;639.4735];
n = [10;100;1000;2000;3000]

data = polyfit(n, tarr, 3);
minDim = min(n);
maxDim = max(n);
datax = [minDim: (maxDim-minDim)/100000:maxDim];
datay = polyval(data, datax);
plot(datax,datay, 'r');
hold on

plot(n, tarr, 'k*', 'MarkerSize', 5);


n = 1:3000;
f = 2*(n.^3) + (n.^2) + (5*n) + 10;
f = f*(11.553e-9);
plot(n, f);
title('Complexity of Modified Gram Schmidt');
xlabel('Input Matrix A^{n x n}');
ylabel('Timetaken (s) ');
legend('Algorithmic Complexity (Fitting Curve)', 'Actual Points ', 'Theoritical Complexity');