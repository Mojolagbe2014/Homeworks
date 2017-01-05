clc; clear;

%fig 7
file1 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\square\Etot_no_loss.mat';
file2 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\square\Etot_loss.mat';
file3 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\square\xx.mat';
file4 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\square\yy.mat';


E_no_loss = open(file1);
E_loss = open(file2);
xx = open(file3);
yy = open(file4);

E1 = E_no_loss.aE_tot;
E2 = E_loss.aE_tot;
x = xx.xx;
y = yy.yy;

% no loss at x = 0;
Ex0_no_loss = ( E1(:,100) + E1(:,101) )/2;
% loss at x = 0;
Ex0_loss = ( E2(:,100) + E2(:,101) )/2;

% no loss at y = 0;
Ey0_no_loss = ( E1(100,:) + E1(101,:) )/2;
% loss at y = 0;
Ey0_loss = ( E2(100,:) + E2(101,:) )/2;

figure(11)
plot(y(:,1),Ex0_no_loss,'-k', 'LineWidth', 2 )
hold on;
plot(y(:,1),Ex0_loss,'--k', 'LineWidth', 2 )
legend('\epsilon = 4','\epsilon = 2+0.1i');
xlabel( 'Y, \lambda' , 'FontSize', 14)
ylabel( '|E/Ei| at X = 0' , 'FontSize', 14)
set(gca,'YTick', 0:0.2:1.4,'FontSize', 14 )
grid on;
line( [-0.5 -0.5 ] ,[0 1.4] , 'Color' , 'r', 'LineWidth', 2)
line( [0.5 0.5 ] ,[0 1.4] , 'Color' , 'r', 'LineWidth', 2)

figure(12)
plot(x(1,:)',Ey0_no_loss,'-k', 'LineWidth', 2 )
hold on;
plot(x(1,:)',Ey0_loss,'--k', 'LineWidth', 2 )
legend('\epsilon = 4','\epsilon = 2+0.1i');
xlabel( 'X, \lambda' , 'FontSize', 14)
ylabel( '|E/Ei| at Y = 0' , 'FontSize', 14)
set(gca,'YTick', 0:0.2:1.4,'FontSize', 14 )
grid on;
line( [-0.5 -0.5 ] ,[0 1.4] , 'Color' , 'r', 'LineWidth', 2)
line( [0.5 0.5 ] ,[0 1.4] , 'Color' , 'r', 'LineWidth', 2)
