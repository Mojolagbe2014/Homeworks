clear; clc; close all;

n = 100;

c1 = 6;          % upper bound 
c2 = 2/3;        % lower bound (x = -16/3)

for x = 1:n
    fx(x) = f(x);
    gx(x) = c1*g(x);
    gx2(x) = c2*g(x);
end 


x = 1:n;
plot(x, fx, '-', x, gx, '-.', x, gx2);
set(gca,'FontSize',20);
legend('f(x)', 'c_1g(x) - Upper Bound', 'c_2g(x) - Lower Bound');