close all; clear; clc;

%% set parameters 
pt = [0.601520508819592, 0.302588842619159];
sides = [101 104 103 102];                                  % line physics for the domain (probe point comes last)
V1 = 100;                                                   % apply potential to the probe point
rhoType = 5;                                                % set the type of excitation used (1-5)
epsilon = 1;                                              % dielectric constant of the domain
width = 1;                                                  % width of the domain
height = 1;                                                 % height of the doamin
maxIter = 100;                                              % maximum iterations for analytic solution
MeshData = GmshReadM('mesh_files/flat_plate.msh');          % Use GmshreadM to read the Gmsh mesh file

%% obtain element for the selected point 
thisElement = getEleIndices(MeshData, pt);
xp = pt(1);                                                                          % x coordinate of the point
yp = pt(2);                                                                          % y coordinate of the point
y = MeshData.yNodes;
x = MeshData.xNodes;
A = MeshData.TriangleArea(thisElement);

%% solve the grid using  both first and second order
[phi] = solveAnalytic(width, height, MeshData,V1, maxIter, sides);
[phi1] = solveFirstOrder(MeshData,V1, rhoType, epsilon, sides);
[phi2, MeshData2] = solveSecondOrder(MeshData,V1, rhoType, epsilon, sides, 'data/Q.mat', 'data/R.mat', 'data/T.mat');

%% get the first and second order nodes of the element of the selected point
fOrderNodes = MeshData.EleMatrix(thisElement, 1:3);
sOrderNodes = MeshData2.EleMatrix(thisElement, 1:6);


%% determine the potential from first order element
P1 = y(fOrderNodes(2)) - y(fOrderNodes(3));             % (y2 - y3)
P2 = y(fOrderNodes(3)) - y(fOrderNodes(1));             % (y3 - y1)
P3 = y(fOrderNodes(1)) - y(fOrderNodes(2));             % (y1 - y2)
Q1 = x(fOrderNodes(3)) - x(fOrderNodes(2));             % (x3 - x2)
Q2 = x(fOrderNodes(1)) - x(fOrderNodes(3));             % (x1 - x3)
Q3 = x(fOrderNodes(2)) - x(fOrderNodes(1));             % (x2 - x1)
denom = 2 * A;                                          % 2*Area of the triangle

a1 = x(fOrderNodes(2))*y(fOrderNodes(3)) - x(fOrderNodes(3))*y(fOrderNodes(2));
a2 = x(fOrderNodes(3))*y(fOrderNodes(1)) - x(fOrderNodes(1))*y(fOrderNodes(3));
a3 = x(fOrderNodes(1))*y(fOrderNodes(2)) - x(fOrderNodes(2))*y(fOrderNodes(1));

alpha = ((1/denom)*[a1 P1 Q1; a2 P2 Q2; a3 P3 Q3]*[1; xp; yp]);


phiEle(1) = phi1(fOrderNodes(1))*alpha(1) + phi1(fOrderNodes(2))*alpha(2) + phi1(fOrderNodes(3))*alpha(3);

%% determine the potential from second order element
alp1 = alpha(1);                                                   % calc. shape function 1
alp2 = alpha(2);                                                   % calc. shape function 2
alp3 = alpha(3);                                                   % calc. shape function 3

alpha1 = alp1*((2*alp1)-1);  alpha2 = 4*alp1*alp2;  alpha3 = 4*alp1*alp3;
alpha4 = alp2*((2*alp2)-1);  alpha5 = 4*alp2*alp3;  alpha6 = alp3*((2*alp3)-1);

phiEle(2) = phi2(sOrderNodes(1))*alpha1 + phi2(sOrderNodes(2))*alpha2 + phi2(sOrderNodes(3))*alpha3 ...
    + phi2(sOrderNodes(4))*alpha4  + phi2(sOrderNodes(5))*alpha5  + phi2(sOrderNodes(6))*alpha6;
    
sigma = 0;
for m = 1:1:maxIter
    if mod(m, 2) == 1 
        sigma = sigma + (sin((m*pi*xp)./width) * sinh((m*pi*yp)./width)) ./ (m * sinh((m*pi*height)./width));
    end 
    sigma2 = 0;
    for n = 1:1:maxIter
        A = (1/(((m*pi/width).^2) + ((n*pi/height).^2))) *  (((((-1).^(m+n))*144*width*height)/(m*n*pi))*(1-(1/height)*(1-(-1).^n)));
        sigma2 = sigma2 + A*sin((n*pi*xp)/width)*sin((n*pi*yp)/height);
    end
end
    phin = (((4 * V1)./pi) *  sigma) + sigma2;

ans = abs(phi1 - phi2(1:568))./abs(phi1);
figure(1)
trisurf(MeshData.EleMatrix,MeshData.xNodes,MeshData.yNodes,ans)
zlabel('Potential (V)');
ylabel('y-axis');
xlabel('x-axis');
view(2);
colorbar;
shading interp; 
hold
set(gcf,'render','zbuffer');
