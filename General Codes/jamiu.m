clear; close all; clc;

x = 1;
n = 5;

X = zeros(n+1,n+1);
X(1,1) = x;


for i = 1:n
    for j = 1:i
        X(i+1, j) =  X(i+1, j) + X(i, j) - 1;
        X(i+1, j+1) =  X(i+1, j+1) + X(i, j) + 1;
    end
    
end 
 
sum(X(n+1,:))

figure
stairs(X)
figure
bar(X)
figure
feather(X)

figure,
imagesc(X),
colormap hot
axis square