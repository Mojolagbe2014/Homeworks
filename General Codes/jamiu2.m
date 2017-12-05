clear; close all; clc;

x = 0.02;
n = 5;
incr = 0.01;
start = 0.01;

X = zeros(n+1,n+1);
X(1,1) = x;


for i = start:incr:n
    for j = start:incr:i
        X(i+1, j) =  X(i+1, j) + X(i, j) - incr;
        X(i+1, j+1) =  X(i+1, j+1) + X(i, j) + incr;
    end
    
end

sum(X(n,:))

% figure
% stairs(X)
% figure
% bar(X)
% figure
% feather(X)

% figure,
% imagesc(X),
% colormap hot
% axis square