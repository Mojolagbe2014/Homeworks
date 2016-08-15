% demoTrapezoidalAlgorithm.m
%   Determine the integral(area under the curve) 
%       by trapezoidal method algorithm
%           using matlab built in humps() as test function
%
%               Author: Jamiu Mojolagbe

clc; 
clear; 
clf;

%% define anonymous function as test function
%   using the built in matlab humps() method
hp = @(x) humps(x);
% hp = @(x) (x.^1);
% hp = @(x) (x.^2);
% hp = @(x) (x.^3);
% hp = @(x) (x).^4;

%% set parameters
xmin = 0;       % minimum x-axis value
xmax = 1;       % max x-axis value
Nx = 300;       % number of linear points to be generated between xmin & xmax

Np = 10;        % number of linear points to be generated between a & b for our integration
a = 0.13;       % lower bound of integration
b = 0.5;        % upper bound of integration


%% tabulate function humps 
x = linspace(xmin, xmax, Nx);
f = hp(x);

% tabulate this to show the area under intergration
x2 = linspace(a, b, Np);
f2 = hp(x2);

%% calculate the integral of the curve 
thisTrapez = trapez(hp, a, b, Np);            % solution from the written trapez() 
thisSimps = simps(hp, a, b, Np);              % solution from the written simps()

matTrapzFunc = trapz(x2, f2);                 % equivalent solution by trapz() matlab function
matIntegralFunc = integral(hp, a, b);         % equivalent solution by integral() matlab function


%% display the results and compare with built in matlab functions
disp('******* RESULTS OF TRAPEZOIDAL ALGORITHM ******* ');
disp(['My Trapezoidal Integration: ', num2str(thisTrapez, 8)]);
disp('  Compare with:');

errorpct1 = 100*abs(thisTrapez-matTrapzFunc)/matTrapzFunc;
disp(['     Matlab trapz() function: ', num2str(matTrapzFunc, 8), ...
    '   Error: ', num2str(errorpct1, 8), '%']);

errorpct2 = 100*abs(thisTrapez-matIntegralFunc)/matIntegralFunc;
disp(['     Matlab integal() function: ', num2str(matIntegralFunc, 8),...
    '   Error: ', num2str(errorpct2, 8), '%']);

disp(' ');

disp('******* RESULTS OF SIMPSON''S ALGORITHM ******* ');
disp(['My Simpson''s Integration: ', num2str(thisSimps, 8)]);
disp('  Compare with:');

errorpct3 = 100*abs(thisSimps-matTrapzFunc)/matTrapzFunc;
disp(['     Matlab trapz() function: ', num2str(matTrapzFunc, 8), ...
    '   Error: ', num2str(errorpct3, 8), '%']);

errorpct4 = 100*abs(thisSimps-matIntegralFunc)/matIntegralFunc;
disp(['     Matlab integal() function: ', num2str(matIntegralFunc, 8),...
    '   Error: ', num2str(errorpct4, 8), '%']);

errorpct5 = 100*abs(thisSimps-thisTrapez)/thisTrapez;
disp(['     My trapez() function: ', num2str(thisTrapez, 8),...
    '   Error: ', num2str(errorpct5, 8), '%']);



%% plot the function for the sake of clarity
plot(x, f, x2, f2, 'ro--');
grid on
xlabel('x');
ylabel('f(x)');
title(['Graph of f(x) = humps(x)', '    Minimum X = ', num2str(xmin),...
    ' Maximum X = ', num2str(xmax), ' Number of points = ', num2str(Nx)]) 
legend('humps(x)', 'Area Integrated');
