%% fdtdLossy.m
%   Demonstrate FDTD transmission line assuming lossy tx-line
%
%       Problem: Transmission line simulation 
%       Method:  Numerical Solutions
%        
%       Course:     ECE 7810
%       Homework:   3
%       Sub. Date:  November 14, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca
close all; clear; clc;

%% set parameters
C = 50e-12;                                                                 % p.u.l capacitance
L = 0.5e-6;                                                                 % p.u.l inductance
R = 0.1;                                                                    % p.u.l resistance
G = 0.001;                                                                  % p.u.l conductance
c0 = 1/sqrt(C*L);                                                           % speed of propagation
Len = 1;                                                                    % length of the wire
pauseFor = 0.15;                                                            % pause the plot for / determines the speed the lower the value the higher the speed
totalSteps = 300;                                                           % total steps for the animation 
CFL = 1.00;                                                                 % CFL stability factor
num = 100;                                                                  % number of space points
Z0 = sqrt(L/C);                                                             % p.u.l impedance
pulseInit = 0.45;                                                           % start location of the pulse 0 - Len
pulsewidth = 0.10;                                                          % pulse width
A0 = 10;                                                                    % pulse amplitude
pulseBegin = 10e-9;                                                         
pulseEnd = 200e-9;

current = zeros(1, num);                                                    % initialize current array (numerical solution)
voltage = zeros(1, num+1);                                                  % Thevenin voltage array (numerical solution)
current_e = zeros(1, num);                                                  % initialize current array (analytic solution)
voltage_e = zeros(1, num+1);                                                % initialize voltage array (analytic solution)
Rt_near = 0;                                                                % first terminating  resistance 
Vt_near = 0;                                                                % Thevenin (terminating) voltage at x=0
% Rt_far = sqrt(L/C);
Rt_far = inf;                                                               % second terminating resistance
Vt_far = 0;                                                                 % Thevenin (termination) voltage at x=1


%% set up fdtd numerical parameters and discretize
dx = Len/num;                                                               % space step size
dt = CFL*dx/c0;                                                             % time step based on CFL stability condition.
xv = (0:num)*dx;                                                            % vector of space locations for voltage
xi = (1:num)*dx-dx/2;                                                       % vector of space locations for current


%% setup/specify the pulse type (Square | Gaussian)
% pb = int16(num*pulseInit); pe = int16((num*(pulseInit+pulsewidth)));        % specify location of pulse
% voltage(pb:pe) = A0*ones(1,length(pb:pe));                                  % square pulse as initial condition
% voltage_e(pb:pe) = A0*ones(1,length(pb:pe));
x=1:num+1;
param = num/2;
voltage = exp(-((x-param).^2)/param);
voltage_e = exp(-((x-param).^2)/param);


%% plot the initial voltage and current
subplot(2,1,1)
plot(xi, current)
xlim([min(xi), max(xi)]);
xlabel('Length along Tx-Line [m]')
ylabel('Current')
title(['Time = ' num2str(0)  ' [nsec]']);

subplot(2,1,2)
plot(xv, voltage)
xlabel('Length along Tx-Line [m]')
ylabel('Voltage')
title(['Time = ' num2str(0) ' [nsec]']);

reply = input('More? y/n [y]: ', 's');
if reply == 'n' 
    return 
end;    
n = 1;                                                                      % initialize time stamp/step
tv = n* dt;                                                                 % time duration for voltage
ti = tv - dt/2;                                                             % time duration for current
factor = dt/dx;


%% Set Boundary conditions
% voltage(1) = Vt_near - current(1)*Rt_near;
% voltage(num+1) = Vt_far + current(num)*Rt_far;
if(Rt_near == Inf); voltage(1) = voltage(2); 
else voltage(1) = Vt_near - current(1)*Rt_near;  
end
if(Rt_far == Inf);    voltage(num+1) = voltage(num); 
else voltage(num+1) = Vt_far + current(num)*Rt_far; 
end


%% update interior points of the numerical solution 
% ******first update is different for the current (need to divide factor by 2)
current(1:num) = current(1:num) - (factor/L/2)*(voltage(2:num+1) - voltage(1:num)) - R*current(1:num);
voltage(2:num) = voltage(2:num) - (factor/C)*(current(2:num) - current(1:num-1)) - G*voltage(2:num);


%% plot the first update of voltage and current
subplot(2,1,1)
plot(xi, current);
xlim([min(xv), max(xv)]);
xlabel('Length along Tx-Line [m]');
ylabel('Current');
title(['Time = ' num2str(round(ti*1e12)/1000) '[nsec]']);

subplot(2,1,2);
plot(xv, voltage);
xlabel('Length along Tx-Line [m]')
ylabel('Voltage')
title(['Time = ' num2str(round(tv*1e12)/1000) '[nsec]']);

reply = input('More? y/n [y]: ', 's');
    if reply == 'n' 
        return 
    end;    


%% loop through the number of steps given to produce movie effect
% while n <= totalSteps 
stop = 0;
while stop == 0 
    n = n + 1;
    tv = n* dt;
    ti = tv - dt/2;

    % Boundary Conditions
    % calculate Thevenin voltage
    if tv > pulseBegin && tv < pulseEnd
        Vt_near = 0;
    else
        Vt_near = 0;
    end
    if(Rt_near == Inf)
       voltage(1) = voltage(2);     
    else
        voltage(1) = Vt_near - current(1)*Rt_near;
    end
    if(Rt_far == Inf)
       voltage(num+1) = voltage(num); 
    else
        voltage(num+1) = Vt_far + current(num)*Rt_far; 
    end
    
    % Update interior points
    current(1:num) = current(1:num) - (factor/L)*(voltage(2:num+1) - voltage(1:num)) - R*current(1:num);
    voltage(2:num) = voltage(2:num) - (factor/C)*(current(2:num) - current(1:num-1)) - G*voltage(2:num);;
        
    % Plot
    subplot(2,1,1)
    plot(xi, current);
    xlim([min(xv), max(xv)]);
    xlabel('Length along Tx-Line [m]');
    ylabel('Current');
    title(['Time = ' num2str(round(ti*1e12)/1000) ' [nsec]']);
    
    subplot(2,1,2);
    plot(xv, voltage);
    xlabel('Length along Tx-Line [m]')
    ylabel('Voltage')
    title(['Time = ' num2str(round(tv*1e12)/1000) ' [nsec]']);
    
    reply = input('More? y/n [y]: ', 's');
    if reply == 'n' 
        stop = 1 
    end;     
%     pause(pauseFor);     
end 
