%% Tlp bounding solver
clear; clc; close all;

%% set parameters
maxIter = 100;
n_max = 10;
K(1) = 0;
c_al = 6.6;
c_0 = 0;
c_la = 18.3;
error = 0;

%% do newton-raphson iteration
for i=2:maxIter
    K(i) = K(i-1) +  (f(c_al,c_0, c_la, K(i-1), n_max) / fp(K(i-1), n_max));
    error(i) = K(i) - K(i-1);
end

K(maxIter)


%% plot the results
iter = 1:maxIter;

figure
subplot(1,2,1)
plot(iter,K,'-b')
xlabel('Number of Iteratons')
ylabel('K')
title('Plot of K against iterations')
grid on
grid minor

subplot(1,2,2)
plot(iter,error,'-r')
xlabel('Number of Iteratons')
ylabel('Error')
title('Plot of Errors vs. iterations')
grid on
grid minor



