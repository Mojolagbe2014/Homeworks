close all
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem Description                         %%
% -------------------                         %%
% 2D FEM for a simple electrostatic           %%
% problem based on Laplace's Equation         %%
%                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Use GmshreadM to read the Gmsh mesh file
MeshData = GmshReadM('flat_plate.msh');

nodes = MeshData.nNodes;    % the number of nodes
x = MeshData.xNodes;        % the x-coordinate of the nodes
y = MeshData.yNodes;        % the y-coordinate of the nodes
epsilon = 10.0;

% create the nodes matrix
nodes_matrix = [MeshData.NodesID(:) x(:) y(:)];

% create
nelements = MeshData.nElements;
nelematrix = MeshData.EleMatrix;

% Constraint and Potential Vector for the boundary nodes
 
constr = zeros(nodes,1);  % Constraint identification vector, will be set
                          % to 1 if the node is a Dirichlet node
potent = zeros(nodes,1);  % Solution vector, this is what is solved for
 
% Setting the constraint vector equal to one for boundary values
% MeshData.BdNodes contains the indices of the boundary nodes
constr(MeshData.BdNodes) = 1;
 
% Setting the boundary conditions based on the Line Physics
% get the lines having LinePhysics == 100
% and store the list of points on the line in ProbePoints
% tmp = find(MeshData.LinePhysics == 100);
tmp = find((MeshData.LinePhysics == 101)  | (MeshData.LinePhysics == 103));
ProbePoints = unique(MeshData.LineMatrix(tmp,:));

% Grounded Points
% get the lines having LinePhysics == 101 and 102
% and store the list of points on the line in GroundPoints
% tmp = find((MeshData.LinePhysics == 101) | (MeshData.LinePhysics == 102));
tmp = find((MeshData.LinePhysics == 102) | (MeshData.LinePhysics == 104));
GroundPoints = unique(MeshData.LineMatrix(tmp,:));

% Set the value of the potential appropriately
potent(ProbePoints) =  1;
potent(GroundPoints) = 0;   

% Allocate memory
telm =  zeros(3,3);
selm = zeros(3,3);
RHS = zeros(nodes,1);
S = zeros(nodes,nodes);
S = sparse(S);
 
for n = 1:nelements
    % Form stiffness and mass matrices, selm and telm, for each element    
    % Allocate memory
    telm = zeros(3,3);
    selm = zeros(3,3);
    CNTG = 0;
    
    ii = nelematrix(n,1);
    jj = nelematrix(n,2);
    kk = nelematrix(n,3);
    ll = 0;
    
    % Calculate the area current element
    area = ((x(jj)-x(ii)).*(y(kk)-y(ii)) - (x(kk)-x(ii)).*(y(jj)-y(ii)))/ 2.0;
        
    % Calculate S-element for an individual element using cotangent method
    i1 = 1;    i2 = 2;    i3 = 3;    i4 = 0;
    for l = 1:3
        CNTG = ((x(jj) - x(ii)) .* (x(kk) - x(ii)) + (y(jj) - y(ii)) .* (y(kk) - y(ii)))./(4.0.*area);
        selm(i2,i2) = selm(i2,i2) + CNTG;
        selm(i2,i3) = selm(i2,i3) - CNTG;
        selm(i3,i2) = selm(i3,i2) - CNTG;
        selm(i3,i3) = selm(i3,i3) + CNTG;
        
        i4 = i1;        i1 = i2;        i2 = i3;        i3 = i4;
        ll = ii;        ii = jj;        jj = kk;        kk = ll;
    end
    
    
    rho = getDensity(MeshData.xCentroids(n), MeshData.yCentroids(n));
    Pe(n, 1) = (rho*area)./ (3*epsilon);
    
    % Assemble the Global S Matrix
    for l = 1:3
        irow = nelematrix(n,l);
        
        if constr(irow) == 1                            % If it is a constrainted node
            S(irow,irow) = 1;                           % add a 1 to the diagonal on the irow row
            RHS(irow) = potent(irow);                   % RHS will be the potential
        else                                            % If it is a free node       
            for m = 1:3                                 % go around the other nodes if it is a free node
                icol = nelematrix(n,m);
                if constr(icol) == 1
                    RHS(irow) = RHS(irow) - selm(l,m).*potent(icol);
                else
                    S(irow,icol) = S(irow,icol) + selm(l,m); 
                end % if constr(icol) == 1
            end % For m
        end % if constr(irow) == 1
    end
end


%% calculate Poisson's RHS
P = zeros(nodes, 1);                                               % initialize Poisson's RHS
for gnode = 1:nodes                                                % loop through the global nodes
    [eleID, localID] = getElementIndices(MeshData, gnode);         % get list of elements that share a node
    totalEle = length(eleID);                                      % number of elements sharing a node
    for ei = 1:totalEle                                            % loop through each element sharing the node
        P(gnode) = P(gnode) + Pe(eleID(ei));                       % add the element Poisson's RHS already calculated
    end
end

%% add Poisson's RHS to already calculated RHS (boundary conditions)
RHS = RHS + P;

%% Invert using the backslash operator
final_solution = S\RHS;


%% Plot the solution
figure(1)
trisurf(nelematrix,x,y,final_solution)
zlabel('Potential (V)');
ylabel('y-axis');
xlabel('x-axis');
view(2);
colorbar;
shading interp; set(gcf,'render','zbuffer');