%% QuestionD.m
%   Demonstrate FDTD to solve shielding problem of Question E
%
%       Problem: 2-D Shielding Problem 
%       Method:  Numerical Solutions
%        
%       Course:     ECE 7810
%       Homework:   3
%       Sub. Date:  November 14, 2016
%
%           Edited by:  Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca
close all; clear; clc;

%% set parameters
plotHz = 0;                                                                 % plot scattered Hz field  (1=yes, 0=no)
plotEx = 0;                                                                 % plot scattered Ex field (1=yes, 0=no)
plotEy = 0;                                                                 % plot scattered Ey field (1=yes, 0=no)
plotHt = 1;                                                                 % plot total H field (1=yes, 0=no)
stopAtTenIter = 0;                                                          % pause computation and request input at each {stopDist} time step (1=yes, 0=no)
stopDist = 50;                                                              % stopage iteration count
ABCorder = 2;                                                               % order of ABC (1 or 2)
ABCapproxType = 1;                                                          % E-field only = 1, H-field = 2
ABCcornerType = 1;                                                          % 1-first order, central difference | 2-first order, corner average | 3-diagonal derivative | 4-simple side-average | 5-no corner ABC
theta = 0;                                                                 % incident field incidence angle starting from -x axis in degrees
dist = 0.6;                                                                 % distance of plane wave from origin (bottom-left of plot window). Each unit places it 0.3m away
max_iteration = 700;                                                        % number of iterations
cbarmax = 1;                                                                % plot color-bar max range
e0 = 8.8541878176e-12;                                                      % absolute dielectric constant
m0 = (4*pi)*1e-7;                                                           % absolute permiability
Len = 0.30;                                                                 % domain side length in metres
c0 = 1/(sqrt(e0*m0));                                                       % speed of propagation
CFL = 1.0;                                                                  % CFL stability factor
h = 0.001;                                                                  % space step size (metres)
% The Ez component of the total field is saved at observation points 
% for each time-step. These points must coincide with actual grid points
obsx = [0.05; 0.15];                                                        % observation-point x-coordinate locations
obsy = [0.05; 0.15];                                                        % observation-point y-coordinate locations
                      
% set list of (x,y) coordinates that make up PEC boundary.  
% the points so created must coincide with actual grid-points.
xin_st = 0.005;
xin_end = 0.105;
xout_st = 0;
xout_end = 0.11;
yin_st = 0.005;
yin_end = 0.085;
yout_st = 0;
yout_end = 0.09;
yin_st2 = 0.065; 
yout_st2 = 0.065;
yin_end2 = 0.025; 
you_end2 = 0.025;


%% calculate other needed parameters
num = int16(Len/h + 1);                                                     % number of space points
k = CFL*h/(c0*sqrt(2));                                                     % time step based on CFL stability condition.
% plane wave parameters
v = -c0 * [-cos(theta*2*pi/360), sin(theta*2*pi/360)];                      % velocity vector


%% allocate spatial matrices of the grid
Hz = zeros(num);                                                            % matrix holding Hz component of scattered field
Hprev = Hz;                                                                 % Hz matrix from previous step
Hbrev = Hprev;                                                              % Hz matrix previous to previous step
Ex = zeros(num-1, num);                                                     % matrix holding Ex component of scattered field
Ey = zeros(num, num-1);                                                     % matrix holding Ey component of scattered field
Ht = zeros(num);                                                            % matrix holding Hz component of total field
Hinc = zeros(num);                                                          % matrix holding Hz component of incident field
[xcoords, ycoords] = meshgrid(0:h:Len, Len:-h:0);                           % x and y coordinates of grid points within domain
time_axis = zeros(1,max_iteration);                                         % time-axis scale


%% create points for PEC boundary
xin = xin_st:h:xin_end;
xout = xout_st:h:xout_end;
yin = yin_st:h:yin_end;
yout = yout_st:h:yout_end;
yin1 = yin_st:h:yin_end2;   
yout1 = yout_st:h:you_end2;
yin2 = yin_st2:h:yin_end;  
yout2 = yout_st2:h:yout_end;

% from the above, put together a row vectors of x and y coordinates for all the horizontal lines
pecx = [xin, xin, xout, xout];
pecy = [yin_st*ones(1,length(xin)), yin_end*ones(1,length(xin)), zeros(1,length(xout)), yout_end*ones(1,length(xout))];

% add x and y coordinates for all the vertical lines to the list
pecx = [pecx, xin_st*ones(1,length(yin1)), xin_st*ones(1,length(yin2)), xin_end*ones(1,length(yin)), zeros(1,length(yout1)), zeros(1,length(yout2)), xout_end*ones(1,length(yout))];
pecy = [pecy, yin1, yin2, yin, yout1, yout2, yout];

%adjust location of PEC to approximate center of domain with a coordinate shift
shiftx = 0.1;
shifty = 0.1;
pecx = pecx + shiftx;
pecy = pecy + shifty;


%% observation points determination and storage
[obsRows, obsCols] = pointMap(obsx, obsy, h, num);                          % get the row and column indices of the observation points into the spatial matrices 
obsStore = zeros(length(obsRows), max_iteration);                           % create storage vector for the observation points.  Data for each observation point is stored row-wise.


%% check and create plot windows
if plotHz; fig1 = figure; end
if plotEx; fig2 = figure; end
if plotEy; fig3 = figure; end
if plotHt; fig4 = figure; end


%% set absorbing boundary condition (ABC) parameters
factor = (c0*k-h) / (c0*k+h);  

% H-field approx. constants
hfactor = 0;                                                                % first order ABCs
if ABCorder == 2; hfactor = m0*c0/2/(c0*k+h)*c0*k; end                      % second order ABCs
if ABCorder == 1; ABCapproxType = 2; end

% E-field only approx. constants
Cxd = factor;
Cxx = 2*h/(c0*k+h);
Cxfy = (h*(c0*k)^2) / (2*h^2 * (c0*k+h));
Cyd = factor;
Cyy = Cxx;
Cyfx = Cxfy;

% corner constants
cfactor = (2*c0*k-h) / (2*c0*k+h);  
cfactor2 = h / (2*c0*k+h);

%% calculate the fields [Assume all is starting at time step n = 1 | Assume at n=1, Ez=0 everywhere and set PEC boundary]
n = 1;                                                                      % set initila time step
HincPEC = planewave(pecx, pecy, v, n*k, dist);                              % set PEC boundary values in Hz matrix
[row, col] = pointMap(pecx,pecy,h,num);                                     % convert points (x,y) to matrix indices (row,col)
for ii = 1:length(row);  Hz(row(ii),col(ii)) = -HincPEC(ii); end

%**n=1+1/2
% compute first iteration of Hx and Hy then Ez
Ex = Ex - k/h/2/e0*(Hz(1:end-1,:) - Hz(2:end,:));                               % remember that y=0 is last row for Ez
Ey = Ey - k/h/2/e0*(Hz(:,1:end-1) - Hz(:,2:end));
%**n=2
Hbrev = Hprev;
Hprev = Hz;
Hz(2:end-1,2:end-1) = Hz(2:end-1,2:end-1) - k/h/m0*(Ey(2:end-1,1:end-1) - Ey(2:end-1,2:end) + Ex(1:end-1,2:end-1) - Ex(2:end,2:end-1));
Hinc = planewave(xcoords, ycoords, v, n*k, dist);                           % compute plane wave values at given points where the waveform is a Gaussian function.



%% Main loop
tic;    
time_axis(1) = k;
stop = 0;
while stop == 0 && n < max_iteration
    n = n + 1;
    time = n * k; 
    time_axis(n) = time;
    
%     disp(['Iteration: ' int2str(n)]);

    %**n=n
    % set PEC boundary values in Ez matrix
    HincPEC = planewave(pecx, pecy, v, time, dist);

    [row, col] = pointMap(pecx,pecy,h,num);
    for ii = 1:length(row)
       Hz(row(ii),col(ii)) = -HincPEC(ii);
    end

    %**n=n+1/2
    %perform update    
    Ex = Ex - k/h/e0*(Hz(1:end-1,:) - Hz(2:end,:)); %remember that y=0 is last row for Ez
    Ey = Ey - k/h/e0*(Hz(:,1:end-1) - Hz(:,2:end));
    
    %**n=n+1
    Hbrev = Hprev;
    Hprev = Hz;
    Hz(2:end-1,2:end-1) = Hz(2:end-1,2:end-1) - k/h/m0*(Ey(2:end-1,1:end-1) - Ey(2:end-1,2:end) + Ex(1:end-1,2:end-1) - Ex(2:end,2:end-1));
    Hinc = planewave(xcoords, ycoords, v, n*k, dist);
    Ht = Hz + Hinc;
    
    %***store observation point data
    for ii = 1:1:length(obsRows)
        r = obsRows(ii);
        c = obsCols(ii);
        obsStore(ii,n) = Hz(r,c) + Hinc(r,c);
    end % for ii

    switch ABCapproxType
        case 1
            %set ABC on outer boundary using only E-fields  (2nd order)
            % x = 0
            Hz(2:end-1,1) = -Hbrev(2:end-1,2) + Cxd*(Hz(2:end-1,2) + Hbrev(2:end-1,1)) + Cxx*(Hprev(2:end-1,1) + Hprev(2:end-1,2)) + Cxfy*(Hprev(1:end-2,1)-2*Hprev(2:end-1,1)+Hprev(3:end,1)+Hprev(1:end-2,2)-2*Hprev(2:end-1,2)+Hprev(3:end,2));
            % x = end
            Hz(2:end-1,end) = -Hbrev(2:end-1,end-1) + Cxd*(Hz(2:end-1,end-1) + Hbrev(2:end-1,end)) + Cxx*(Hprev(2:end-1,end) + Hprev(2:end-1,end-1)) + Cxfy*(Hprev(1:end-2,end)-2*Hprev(2:end-1,end)+Hprev(3:end,end)+Hprev(1:end-2,end-1)-2*Hprev(2:end-1,end-1)+Hprev(3:end,end-1));
            % y = 0
            Hz(end,2:end-1) = -Hbrev(end-1,2:end-1) + Cyd*(Hz(end-1,2:end-1) + Hbrev(end,2:end-1)) + Cyy*(Hprev(end,2:end-1) + Hprev(end-1,2:end-1)) + Cyfx*(Hprev(end,3:end)-2*Hprev(end,2:end-1)+Hprev(end,1:end-2)+Hprev(end-1,3:end)-2*Hprev(end-1,2:end-1)+Hprev(end-1,1:end-2));
            % y = end
            Hz(1,2:end-1) = -Hbrev(2,2:end-1) + Cyd*(Hz(2,2:end-1) + Hbrev(1,2:end-1)) + Cyy*(Hprev(1,2:end-1) + Hprev(2,2:end-1)) + Cyfx*(Hprev(1,3:end)-2*Hprev(1,2:end-1)+Hprev(1,1:end-2)+Hprev(2,3:end)-2*Hprev(2,2:end-1)+Hprev(2,1:end-2));

        case 2
            %set ABC on outer boundary using H-field approximation  (2nd order)
            %at x = 0
            Hz(2:end-1,1) = Hprev(2:end-1,2) + factor*(Hz(2:end-1,2)-Hprev(2:end-1,1)) - hfactor*(Ex(1:end-1,1)-Ex(2:end,1)+Ex(1:end-1,2)-Ex(2:end,2));
            %at x = end
            Hz(2:end-1,end) = Hprev(2:end-1,end-1) + factor*(Hz(2:end-1,end-1)-Hprev(2:end-1,end)) - hfactor*(Ex(1:end-1,end)-Ex(2:end,end)+Ex(1:end-1,end-1)-Ex(2:end,end-1));
            %at y = 0
            Hz(end,2:end-1) = Hprev(end-1,2:end-1) + factor*(Hz(end-1,2:end-1)-Hprev(end,2:end-1)) + hfactor*(Ey(end,2:end)-Ey(end,1:end-1)+Ey(end-1,2:end)-Ey(end-1,1:end-1));
            %at y = end
            Hz(1,2:end-1) = Hprev(2,2:end-1) + factor*(Hz(2,2:end-1)-Hprev(1,2:end-1)) + hfactor*(Ey(1,2:end)-Ey(1,1:end-1)+Ey(2,2:end)-Ey(2,1:end-1));

    end  %end switch

    switch ABCcornerType
        case 1
            %set ABC at corners (first order central difference)
            Hz(1,1) = cfactor*Hz(2,2) + cfactor2*(Hprev(1,1)+Hprev(1,2)+Hprev(2,1)+Hprev(2,2)-Hz(1,2)-Hz(2,1));
            Hz(end,1) = cfactor*Hz(end-1,2) + cfactor2*(Hprev(end-1,1)+Hprev(end-1,2)+Hprev(end,2)+Hprev(end,1)-Hz(end,2)-Hz(end-1,1));
            Hz(1,end) = cfactor*Hz(2,end-1) + cfactor2*(Hprev(1,end-1)+Hprev(1,end)+Hprev(2,end-1)+Hprev(2,end)-Hz(1,end-1)-Hz(2,end));
            Hz(end,end) = cfactor*Hz(end-1,end-1) + cfactor2*(Hprev(end-1,end)+Hprev(end-1,end-1)+Hprev(end,end-1)+Hprev(end,end)-Hz(end-1,end)-Hz(end,end-1));

        case 2
            %ABC at corners (first order corner average)
            Hz(1,1) = (Hprev(1,2) + factor*(Hz(1,2)-Hprev(1,1)) + Hprev(2,1) + factor*(Hz(2,1)-Hprev(1,1))) / 2;
            Hz(end,1) = (Hprev(end-1,1) + factor*(Hz(end-1,1)-Hprev(end,1)) + Hprev(end,2) + factor*(Hz(end,2)-Hprev(end,1))) / 2;
            Hz(1,end) = (Hprev(1,end-1) + factor*(Hz(1,end-1)-Hprev(1,end)) + Hprev(2,end) + factor*(Hz(2,end)-Hprev(1,end))) / 2;
            Hz(end,end) = (Hprev(end,end-1) + factor*(Hz(end,end-1)-Hprev(end,end)) + Hprev(end-1,end) + factor*(Hz(end-1,end)-Hprev(end,end))) / 2;
    
        case 3
            %simple ABC at corners (diagonal derivative)
            Hz(1,1) = dfactor*Hz(2,2) + b*(Hprev(1,1)+Hprev(2,2));
            Hz(end,1) = dfactor*Hz(end-1,2) + b*(Hprev(end,1)+Hprev(end-1,2));
            Hz(1,end) = dfactor*Hz(2,end-1) + b*(Hprev(1,end)+Hprev(2,end-1));
            Hz(end,end) = dfactor*Hz(end-1,end-1) + b*(Hprev(end,end)+Hprev(end-1,end-1));

        case 4
            %simple ABC at corners (average)
            Hz(1,1) = (Hz(1,2) + Hz(2,1)) / 2;
            Hz(end,1) = (Hz(end,2) + Hz(end-1,1)) / 2;
            Hz(1,end) = (Hz(1,end-1) + Hz(2,end)) / 2;
            Hz(end,end) = (Hz(end,end-1) + Hz(end-1,end)) / 2;
            
        otherwise
    
    end %end switch
    
    if plotHz
        figure(fig1);        
        imagesc(Hz);
        caxis([-cbarmax cbarmax]);
        title(['H_z Scattered Time = ' num2str(round(time*1e13)/10) ' [psec],  n = ' num2str(n)]);
    end
    if plotEx
        figure(fig2);
        imagesc(Ex); 
        caxis([-cbarmax cbarmax]); 
        title(['E_x Scattered Time = ' num2str(round((time+k/2)*1e13)/10) ' [psec],  n = ' num2str(n)]);
    end
    if plotEy
        figure(fig3);
        imagesc(Ey); 
        caxis([-cbarmax cbarmax]); 
        title(['E_y Scattered Time = ' num2str(round((time+k/2)*1e13)/10) ' [psec],  n = ' num2str(n)]);
    end
    if plotHt
        figure(fig4);            
        imagesc(Ht); 
        caxis([-cbarmax cbarmax]);    
        title(['Ht Time = ' num2str(round(time*1e13)/10) ' [psec],  n = ' num2str(n)]);
    end

    if(plotHz+plotEx+plotEy+plotHt)
        pause(0.01)
    end  %if

    if stopAtTenIter && mod(n, stopDist) == 0
        reply = input('More? y/n [y]: ', 's');
            if reply == 'n' 
                return 
            end;    
    end  %end if
end %main update loop
toc


%% output the observation point results
disp('starting post processing');
tic
for ii = 1:1:length(obsRows)
    figure
    plot(time_axis, obsStore(ii,:));
    title(['Observation Point ' int2str(ii) ' at (' num2str(obsx(ii), 4) ', ' num2str(obsy(ii), 4) ')']);
    xlabel('Time (s)');
    ylabel('Total Field H_z (A/m)');
end %for ii
toc
