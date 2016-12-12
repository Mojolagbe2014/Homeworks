clear all
close all
clc

%*****Options
plotEz = 0;  %plot scattered field (1=yes, 0=no)
plotHx = 0;
plotHy = 0;
plotEt = 1;

inputAtEachStep = 0;  %pause computation and request input at each time step (1=yes, 0=no)

ABCorder = 2;  %order of ABC (1 or 2)
ABCapproxType = 2;  %E-field only = 1, H-field = 2
ABCcornerType = 1;  %1-first order, central difference
                    %2-first order, corner average
                    %3-diagonal derivative
                    %4-simple side-average
                    %5-no corner ABC

theta = 45;  % incident field incidence angle starting from -x axis in degrees
dist = 0.6;   %distance of plane wave from origin (bottom-left of plot window). Each unit places it 0.3m away
max_iteration = 700;  %number of iterations
cbarmax = 1; % plot colour-bar max range

% *****Program begins
e0 = 8.8541878176e-12;
m0 = (4*pi)*1e-7;

Len = 0.30;     %domain side length in metres
c0 = inv(sqrt(e0*m0));          % speed of propagation
CFL = 1.0;                  % CFL stability factor
h = 0.001;          % space step size (metres)
num = int16(Len/h + 1);                  % number of space points
k = CFL*h/(c0*sqrt(2));  % time step based on CFL stability condition.

% plane wave parameters
v = -c0 * [-cos(theta*2*pi/360), sin(theta*2*pi/360)];  % velocity vector

%allocate spatial matrices
Ez = zeros(num);  %matrix holding Ez component of scattered field
Eprev = Ez;       %Ez matrix from previous step
Ebrev = Eprev;    %Ez matrix previous to previous step
Hx = zeros(num-1, num);  %matrix holding Hx component of scattered field
Hy = zeros(num, num-1);  %matrix holding Hy component of scattered field
Et = zeros(num);        %matrix holding Ez component of total field
Einc = zeros(num);      %matrix holding Ez component of incident field
[xcoords, ycoords] = meshgrid(0:h:Len, Len:-h:0);  %x and y coordinates of grid points within domain
time_axis = zeros(1,max_iteration);  %time-axis scale

%%%creation of points for PEC boundary
% create list of (x,y) coordinates that make up PEC boundary.  The points
% so created must coincide with actual grid-points.
xin_st = 0.005;
xin_end = 0.105;
xout_st = 0;
xout_end = 0.11;
yin_st = 0.005;
yin_end = 0.085;
yout_st = 0;
yout_end = 0.09;

yis = 0.065; yos = 0.065;

yie = 0.025; yoe = 0.025;

xin = xin_st:h:xin_end;
xout = xout_st:h:xout_end;
yin = yin_st:h:yin_end;
yout = yout_st:h:yout_end;

yin1 = yin_st:h:yie;   yout1 = yout_st:h:yoe;
yin2 = yis:h:yin_end;  yout2 = yos:h:yout_end;

% from the above, put together a row vectors of x and y coordinates for all
% the horizontal lines
pecx = [xin, xin, xout, xout];
pecy = [0.005*ones(1,length(xin)), 0.085*ones(1,length(xin)), zeros(1,length(xout)), 0.09*ones(1,length(xout))];

% add x and y coordinates for all the vertical lines to the list
pecx = [pecx, 0.005*ones(1,length(yin1)), 0.005*ones(1,length(yin2)), 0.105*ones(1,length(yin)), zeros(1,length(yout1)), zeros(1,length(yout2)), 0.11*ones(1,length(yout))];
pecy = [pecy, yin1, yin2, yin, yout1, yout2, yout];

%adjust location of PEC to approximate center of domain with a coordinate shift
shiftx = 0.1;
shifty = 0.1;
pecx = pecx + shiftx;
pecy = pecy + shifty;

%%%creation of observation point locations.  The Ez component of the total
%%%field is saved at observation points for each time-step.
obsx = [0.05; 0.15];  %column vector of observation-point x-coordinate locations
obsy = [0.05; 0.15];  %column vector of observation-point y-coordinate locations
                      %these points must coincide with actual grid points

%get the row and column indices of the observation points into the spatial matrices 
[obsRows obsCols] = pointMap(obsx, obsy, h, num);

%create storage vector for the observation points.  Data for each
%observation point is stored row-wise.
obsStore = zeros(length(obsRows), max_iteration);

% create plot windows
if plotEz 
    fig1 = figure;
end
if plotHx
    fig2 = figure;
end
if plotHy
    fig3 = figure;
end
if plotEt
    fig4 = figure;
end

%some constants
%ABC H-field approx. constants
factor = (c0*k-h) / (c0*k+h);  
hfactor = 0;                      %first order ABCs
if ABCorder == 2
    hfactor = m0*c0/2/(c0*k+h)*c0*k;  %second order ABCs
end

if ABCorder == 1
    ABCapproxType = 2
end

%ABC E-field only approx. constants
Cxd = factor;
Cxx = 2*h/(c0*k+h);
Cxfy = (h*(c0*k)^2) / (2*h^2 * (c0*k+h));
Cyd = factor;
Cyy = Cxx;
Cyfx = Cxfy;

%ABC Corner constants
cfactor = (2*c0*k-h) / (2*c0*k+h);  
cfactor2 = h / (2*c0*k+h);

%***initial step
% Assume all is starting at time step n = 1
% Assume at n=1, Ez=0 everywhere and set PEC boundary
n = 1;

%**n=1
% set PEC boundary values in Ez matrix
EincPEC = planewave(pecx, pecy, v, n*k, dist);

[row, col] = pointMap(pecx,pecy,h,num);
for ii = 1:length(row)
   Ez(row(ii),col(ii)) = -EincPEC(ii);
end

%**n=1+1/2
% compute first iteration of Hx and Hy then Ez
Hx = -k/h/2/m0*(Ez(1:end-1,:) - Ez(2:end,:)); %remember that y=0 is last row for Ez
Hy = -k/h/2/m0*(Ez(:,1:end-1) - Ez(:,2:end));
%**n=2
Ebrev = Eprev;
Eprev = Ez;
Ez(2:end-1,2:end-1) = Ez(2:end-1,2:end-1) - k/h/e0*(Hy(2:end-1,1:end-1) - Hy(2:end-1,2:end) + Hx(1:end-1,2:end-1) - Hx(2:end,2:end-1));
Einc = planewave(xcoords, ycoords, v, n*k, dist);

%***store observation point data
for ii = 1:1:length(obsRows)
    r = obsRows(ii);
    c = obsCols(ii);
    obsStore(ii,n) = Ez(r,c) + Einc(r,c);
end % for ii

switch ABCapproxType
    case 1
        %set ABC on outer boundary using only E-fields (2nd order)
        % x = 0
        Ez(2:end-1,1) = -Ebrev(2:end-1,2) + Cxd*(Ez(2:end-1,2) + Ebrev(2:end-1,1)) + Cxx*(Eprev(2:end-1,1) + Eprev(2:end-1,2)) + Cxfy*(Eprev(1:end-2,1)-2*Eprev(2:end-1,1)+Eprev(3:end,1)+Eprev(1:end-2,2)-2*Eprev(2:end-1,2)+Eprev(3:end,2));
        % x = end
        Ez(2:end-1,end) = -Ebrev(2:end-1,end-1) + Cxd*(Ez(2:end-1,end-1) + Ebrev(2:end-1,end)) + Cxx*(Eprev(2:end-1,end) + Eprev(2:end-1,end-1)) + Cxfy*(Eprev(1:end-2,end)-2*Eprev(2:end-1,end)+Eprev(3:end,end)+Eprev(1:end-2,end-1)-2*Eprev(2:end-1,end-1)+Eprev(3:end,end-1));
        % y = 0
        Ez(end,2:end-1) = -Ebrev(end-1,2:end-1) + Cyd*(Ez(end-1,2:end-1) + Ebrev(end,2:end-1)) + Cyy*(Eprev(end,2:end-1) + Eprev(end-1,2:end-1)) + Cyfx*(Eprev(end,3:end)-2*Eprev(end,2:end-1)+Eprev(end,1:end-2)+Eprev(end-1,3:end)-2*Eprev(end-1,2:end-1)+Eprev(end-1,1:end-2));
        % y = end
        Ez(1,2:end-1) = -Ebrev(2,2:end-1) + Cyd*(Ez(2,2:end-1) + Ebrev(1,2:end-1)) + Cyy*(Eprev(1,2:end-1) + Eprev(2,2:end-1)) + Cyfx*(Eprev(1,3:end)-2*Eprev(1,2:end-1)+Eprev(1,1:end-2)+Eprev(2,3:end)-2*Eprev(2,2:end-1)+Eprev(2,1:end-2));

    case 2
        %set ABC on outer boundary using H-field approximation  (2nd order)
        %at x = 0
        Ez(2:end-1,1) = Eprev(2:end-1,2) + factor*(Ez(2:end-1,2)-Eprev(2:end-1,1)) - hfactor*(Hx(1:end-1,1)-Hx(2:end,1)+Hx(1:end-1,2)-Hx(2:end,2));
        %at x = end
        Ez(2:end-1,end) = Eprev(2:end-1,end-1) + factor*(Ez(2:end-1,end-1)-Eprev(2:end-1,end)) - hfactor*(Hx(1:end-1,end)-Hx(2:end,end)+Hx(1:end-1,end-1)-Hx(2:end,end-1));
        %at y = 0
        Ez(end,2:end-1) = Eprev(end-1,2:end-1) + factor*(Ez(end-1,2:end-1)-Eprev(end,2:end-1)) + hfactor*(Hy(end,2:end)-Hy(end,1:end-1)+Hy(end-1,2:end)-Hy(end-1,1:end-1));
        %at y = end
        Ez(1,2:end-1) = Eprev(2,2:end-1) + factor*(Ez(2,2:end-1)-Eprev(1,2:end-1)) + hfactor*(Hy(1,2:end)-Hy(1,1:end-1)+Hy(2,2:end)-Hy(2,1:end-1));
        
end %end switch

switch ABCcornerType
    case 1
        %set ABC at corners (first order central difference)
        Ez(1,1) = cfactor*Ez(2,2) + cfactor2*(Eprev(1,1)+Eprev(1,2)+Eprev(2,1)+Eprev(2,2)-Ez(1,2)-Ez(2,1));
        Ez(end,1) = cfactor*Ez(end-1,2) + cfactor2*(Eprev(end-1,1)+Eprev(end-1,2)+Eprev(end,2)+Eprev(end,1)-Ez(end,2)-Ez(end-1,1));
        Ez(1,end) = cfactor*Ez(2,end-1) + cfactor2*(Eprev(1,end-1)+Eprev(1,end)+Eprev(2,end-1)+Eprev(2,end)-Ez(1,end-1)-Ez(2,end));
        Ez(end,end) = cfactor*Ez(end-1,end-1) + cfactor2*(Eprev(end-1,end)+Eprev(end-1,end-1)+Eprev(end,end-1)+Eprev(end,end)-Ez(end-1,end)-Ez(end,end-1));

    case 2
        %ABC at corners (first order corner average)
        Ez(1,1) = (Eprev(1,2) + factor*(Ez(1,2)-Eprev(1,1)) + Eprev(2,1) + factor*(Ez(2,1)-Eprev(1,1))) / 2;
        Ez(end,1) = (Eprev(end-1,1) + factor*(Ez(end-1,1)-Eprev(end,1)) + Eprev(end,2) + factor*(Ez(end,2)-Eprev(end,1))) / 2;
        Ez(1,end) = (Eprev(1,end-1) + factor*(Ez(1,end-1)-Eprev(1,end)) + Eprev(2,end) + factor*(Ez(2,end)-Eprev(1,end))) / 2;
        Ez(end,end) = (Eprev(end,end-1) + factor*(Ez(end,end-1)-Eprev(end,end)) + Eprev(end-1,end) + factor*(Ez(end-1,end)-Eprev(end,end))) / 2;

    case 3
        %simple ABC at corners (diagonal derivative)
        b = sqrt(2*h^2);
        a = b / c0 / sqrt(2);
        dfactor = (2*a*c0-b) / (2*a*c0+b);
        % dfactor2 = (2*a*c0+b) / (2*a*c0-b);
        Ez(1,1) = dfactor*Ez(2,2) + b*(Eprev(1,1)+Eprev(2,2));
        Ez(end,1) = dfactor*Ez(end-1,2) + b*(Eprev(end,1)+Eprev(end-1,2));
        Ez(1,end) = dfactor*Ez(2,end-1) + b*(Eprev(1,end)+Eprev(2,end-1));
        Ez(end,end) = dfactor*Ez(end-1,end-1) + b*(Eprev(end,end)+Eprev(end-1,end-1));

    case 4
        %simple ABC at corners (side average)
        Ez(1,1) = (Ez(1,2) + Ez(2,1)) / 2;
        Ez(end,1) = (Ez(end,2) + Ez(end-1,1)) / 2;
        Ez(1,end) = (Ez(1,end-1) + Ez(2,end)) / 2;
        Ez(end,end) = (Ez(end,end-1) + Ez(end-1,end)) / 2;
        
    otherwise

end %end switch

if plotEz
    figure(fig1);    
    imagesc(Ez);
    caxis([-cbarmax cbarmax]);
    title(['E_z Scattered Time = ' num2str(round(k*1e13)/10) ' [psec],  n = ' num2str(n)]);
end
if plotHx
    figure(fig2);
    imagesc(Hx); 
    caxis([-cbarmax cbarmax]);
    title(['H_x Scattered Time = ' num2str(round(k/2*1e13)/10) ' [psec],  n = ' num2str(n)]);
end
if plotHy
    figure(fig3);
    imagesc(Hy); 
    caxis([-cbarmax cbarmax]);
    title(['H_y Scattered Time = ' num2str(round(k/2*1e13)/10) ' [psec],  n = ' num2str(n)]);
end
if plotEt
    figure(fig4);    
    imagesc(Ez+Einc); 
    caxis([-cbarmax cbarmax]);
    title(['Et Time = ' num2str(round(k*1e13)/10) ' [psec],  n = ' num2str(n)]);
end


if inputAtEachStep
    reply = input('More? y/n [y]: ', 's');
        if reply == 'n' 
            return 
        end;    
end  %end if

%******Main loop

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
    EincPEC = planewave(pecx, pecy, v, time, dist);

    [row, col] = pointMap(pecx,pecy,h,num);
    for ii = 1:length(row)
       Ez(row(ii),col(ii)) = -EincPEC(ii);
    end

    %**n=n+1/2
    %perform update    
    Hx = Hx - k/h/m0*(Ez(1:end-1,:) - Ez(2:end,:)); %remember that y=0 is last row for Ez
    Hy = Hy - k/h/m0*(Ez(:,1:end-1) - Ez(:,2:end));
    
    %**n=n+1
    Ebrev = Eprev;
    Eprev = Ez;
    Ez(2:end-1,2:end-1) = Ez(2:end-1,2:end-1) - k/h/e0*(Hy(2:end-1,1:end-1) - Hy(2:end-1,2:end) + Hx(1:end-1,2:end-1) - Hx(2:end,2:end-1));    
    Einc = planewave(xcoords, ycoords, v, n*k, dist);
    Et = Ez + Einc;
    
    %***store observation point data
    for ii = 1:1:length(obsRows)
        r = obsRows(ii);
        c = obsCols(ii);
        obsStore(ii,n) = Ez(r,c) + Einc(r,c);
    end % for ii

    switch ABCapproxType
        case 1
            %set ABC on outer boundary using only E-fields  (2nd order)
            % x = 0
            Ez(2:end-1,1) = -Ebrev(2:end-1,2) + Cxd*(Ez(2:end-1,2) + Ebrev(2:end-1,1)) + Cxx*(Eprev(2:end-1,1) + Eprev(2:end-1,2)) + Cxfy*(Eprev(1:end-2,1)-2*Eprev(2:end-1,1)+Eprev(3:end,1)+Eprev(1:end-2,2)-2*Eprev(2:end-1,2)+Eprev(3:end,2));
            % x = end
            Ez(2:end-1,end) = -Ebrev(2:end-1,end-1) + Cxd*(Ez(2:end-1,end-1) + Ebrev(2:end-1,end)) + Cxx*(Eprev(2:end-1,end) + Eprev(2:end-1,end-1)) + Cxfy*(Eprev(1:end-2,end)-2*Eprev(2:end-1,end)+Eprev(3:end,end)+Eprev(1:end-2,end-1)-2*Eprev(2:end-1,end-1)+Eprev(3:end,end-1));
            % y = 0
            Ez(end,2:end-1) = -Ebrev(end-1,2:end-1) + Cyd*(Ez(end-1,2:end-1) + Ebrev(end,2:end-1)) + Cyy*(Eprev(end,2:end-1) + Eprev(end-1,2:end-1)) + Cyfx*(Eprev(end,3:end)-2*Eprev(end,2:end-1)+Eprev(end,1:end-2)+Eprev(end-1,3:end)-2*Eprev(end-1,2:end-1)+Eprev(end-1,1:end-2));
            % y = end
            Ez(1,2:end-1) = -Ebrev(2,2:end-1) + Cyd*(Ez(2,2:end-1) + Ebrev(1,2:end-1)) + Cyy*(Eprev(1,2:end-1) + Eprev(2,2:end-1)) + Cyfx*(Eprev(1,3:end)-2*Eprev(1,2:end-1)+Eprev(1,1:end-2)+Eprev(2,3:end)-2*Eprev(2,2:end-1)+Eprev(2,1:end-2));

        case 2
            %set ABC on outer boundary using H-field approximation  (2nd order)
            %at x = 0
            Ez(2:end-1,1) = Eprev(2:end-1,2) + factor*(Ez(2:end-1,2)-Eprev(2:end-1,1)) - hfactor*(Hx(1:end-1,1)-Hx(2:end,1)+Hx(1:end-1,2)-Hx(2:end,2));
            %at x = end
            Ez(2:end-1,end) = Eprev(2:end-1,end-1) + factor*(Ez(2:end-1,end-1)-Eprev(2:end-1,end)) - hfactor*(Hx(1:end-1,end)-Hx(2:end,end)+Hx(1:end-1,end-1)-Hx(2:end,end-1));
            %at y = 0
            Ez(end,2:end-1) = Eprev(end-1,2:end-1) + factor*(Ez(end-1,2:end-1)-Eprev(end,2:end-1)) + hfactor*(Hy(end,2:end)-Hy(end,1:end-1)+Hy(end-1,2:end)-Hy(end-1,1:end-1));
            %at y = end
            Ez(1,2:end-1) = Eprev(2,2:end-1) + factor*(Ez(2,2:end-1)-Eprev(1,2:end-1)) + hfactor*(Hy(1,2:end)-Hy(1,1:end-1)+Hy(2,2:end)-Hy(2,1:end-1));

    end  %end switch

    switch ABCcornerType
        case 1
            %set ABC at corners (first order central difference)
            Ez(1,1) = cfactor*Ez(2,2) + cfactor2*(Eprev(1,1)+Eprev(1,2)+Eprev(2,1)+Eprev(2,2)-Ez(1,2)-Ez(2,1));
            Ez(end,1) = cfactor*Ez(end-1,2) + cfactor2*(Eprev(end-1,1)+Eprev(end-1,2)+Eprev(end,2)+Eprev(end,1)-Ez(end,2)-Ez(end-1,1));
            Ez(1,end) = cfactor*Ez(2,end-1) + cfactor2*(Eprev(1,end-1)+Eprev(1,end)+Eprev(2,end-1)+Eprev(2,end)-Ez(1,end-1)-Ez(2,end));
            Ez(end,end) = cfactor*Ez(end-1,end-1) + cfactor2*(Eprev(end-1,end)+Eprev(end-1,end-1)+Eprev(end,end-1)+Eprev(end,end)-Ez(end-1,end)-Ez(end,end-1));

        case 2
            %ABC at corners (first order corner average)
            Ez(1,1) = (Eprev(1,2) + factor*(Ez(1,2)-Eprev(1,1)) + Eprev(2,1) + factor*(Ez(2,1)-Eprev(1,1))) / 2;
            Ez(end,1) = (Eprev(end-1,1) + factor*(Ez(end-1,1)-Eprev(end,1)) + Eprev(end,2) + factor*(Ez(end,2)-Eprev(end,1))) / 2;
            Ez(1,end) = (Eprev(1,end-1) + factor*(Ez(1,end-1)-Eprev(1,end)) + Eprev(2,end) + factor*(Ez(2,end)-Eprev(1,end))) / 2;
            Ez(end,end) = (Eprev(end,end-1) + factor*(Ez(end,end-1)-Eprev(end,end)) + Eprev(end-1,end) + factor*(Ez(end-1,end)-Eprev(end,end))) / 2;
    
        case 3
            %simple ABC at corners (diagonal derivative)
            Ez(1,1) = dfactor*Ez(2,2) + b*(Eprev(1,1)+Eprev(2,2));
            Ez(end,1) = dfactor*Ez(end-1,2) + b*(Eprev(end,1)+Eprev(end-1,2));
            Ez(1,end) = dfactor*Ez(2,end-1) + b*(Eprev(1,end)+Eprev(2,end-1));
            Ez(end,end) = dfactor*Ez(end-1,end-1) + b*(Eprev(end,end)+Eprev(end-1,end-1));

        case 4
            %simple ABC at corners (average)
            Ez(1,1) = (Ez(1,2) + Ez(2,1)) / 2;
            Ez(end,1) = (Ez(end,2) + Ez(end-1,1)) / 2;
            Ez(1,end) = (Ez(1,end-1) + Ez(2,end)) / 2;
            Ez(end,end) = (Ez(end,end-1) + Ez(end-1,end)) / 2;
            
        otherwise
    
    end %end switch
    
    if plotEz
        figure(fig1);        
        imagesc(Ez);
        caxis([-cbarmax cbarmax]);
        title(['E_z Scattered Time = ' num2str(round(time*1e13)/10) ' [psec],  n = ' num2str(n)]);
    end
    if plotHx
        figure(fig2);
        imagesc(Hx); 
        caxis([-cbarmax cbarmax]); 
        title(['H_x Scattered Time = ' num2str(round((time+k/2)*1e13)/10) ' [psec],  n = ' num2str(n)]);
    end
    if plotHy
        figure(fig3);
        imagesc(Hy); 
        caxis([-cbarmax cbarmax]); 
        title(['H_y Scattered Time = ' num2str(round((time+k/2)*1e13)/10) ' [psec],  n = ' num2str(n)]);
    end
    if plotEt
        figure(fig4);            
        imagesc(Et); 
        caxis([-cbarmax cbarmax]);    
        title(['Et Time = ' num2str(round(time*1e13)/10) ' [psec],  n = ' num2str(n)]);
    end

    if(plotEz+plotHx+plotHy+plotEt)
        pause(0.01)
    end  %if

    if inputAtEachStep
        reply = input('More? y/n [y]: ', 's');
            if reply == 'n' 
                return 
            end;    
    end  %end if
end %main update loop

toc


%*****post-processing

disp('starting post processing');
tic

for ii = 1:1:length(obsRows)
    figure
    plot(time_axis, obsStore(ii,:));
    title(['Observation Point ' int2str(ii) ' at (' num2str(obsx(ii), 4) ', ' num2str(obsy(ii), 4) ')']);
    xlabel('Time (s)');
    ylabel('Total Field E_z (V/m)');
end %for ii

toc
