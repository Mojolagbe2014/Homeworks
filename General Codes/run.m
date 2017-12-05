clear; clc; close all;

n = 20;

c = 6;          % upper bound 
%c = 2/3;        % lower bound (x = -16/3)

for x = 1:n
    fx(x) = f(x);
    gx(x) = c*g(x);
end 


x = 1:n;
plot(x, fx, '-', x, gx, '-.');
set(gca,'FontSize',20);
legend('f(x)', 'cg(x)');