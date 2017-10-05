clear; clc;

x = [0, 0.75, 1];
y = [0, 1, 0.5];
phi = [0 50 100];

P1 = y(2) - y(3)
P2 = y(3) - y(1)
P3 = y(1) - y(2)

Q1 = x(3) - x(2)
Q2 = x(1) - x(3)
Q3 = x(2) - x(1)

a1 = x(2)*y(3) - x(3)*y(2)
a2 = x(3)*y(1) - x(1)*y(3)
a3 = x(1)*y(2) - x(2)*y(1)

% A = 0.3125;
A = 0.5*(Q3*P2 - Q2*P3)
xp = 0.5833;
yp = 0.5;

denom = 2 * A;
alpha = ((1/denom)*[a1 P1 Q1; a2 P2 Q2; a3 P3 Q3]*[1; xp; yp])


phiEle = phi(1)*alpha(1) + phi(2)*alpha(2) + phi(3)*alpha(3)