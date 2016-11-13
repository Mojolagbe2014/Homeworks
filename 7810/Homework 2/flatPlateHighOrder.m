%% flatPlateHighOrder.m
%   Calculate and demonstrate potential distribution
%       on a square plate with source of excitation.
%
%       Problem: Poisson's Equation on a Flat Plate
%       Method:  Numerical Solution (High Order Element)

close all; clear; clc;
%% load given table/matrices
load('data/Q.mat');
load('data/R.mat');
load('data/T.mat')

%% set parameters 
V0 = 0;                                                     % ground potential
V1 = 1;                                                   % probe potential
rhoType = 5;                                                % source excitation variations - has values [0|1|2|3|4]
MeshData = GmshReadM('mesh_files/flat_plate.msh');          % Use GmshreadM to read the Gmsh mesh file
nodes = MeshData.nNodes;                                    % the number of nodes
x = MeshData.xNodes;                                        % the x-coordinate of the nodes
y = MeshData.yNodes;                                        % the y-coordinate of the nodes
epsilon = 1.5;                                             % permittivity of the dielectric material
nodes_matrix = [MeshData.NodesID(:) x(:) y(:)];             % create the nodes matrix
nelements = MeshData.nElements;                             % obtain the total number of elements
nelematrix = MeshData.EleMatrix;                            % elements with corresponding 3 global nodes

constr = zeros(nodes,1);                                    % Constraint identification vector, will be set
                                                            % to 1 if the node is a Dirichlet node
potent = zeros(nodes,1);                                    % Solution vector, this is what is solved for
constr(MeshData.BdNodes) = 1;                               % Set constraint vector equal to one for boundary values
 
tmp = find((MeshData.LinePhysics == 102) );
ProbePoints = unique(MeshData.LineMatrix(tmp,:));           % set probe points
tmp = find((MeshData.LinePhysics == 101) | (MeshData.LinePhysics == 104) | (MeshData.LinePhysics == 103));
GroundPoints = unique(MeshData.LineMatrix(tmp,:));          % set ground points

potent(ProbePoints) =  V1;                                  % set  boundary condition for probe points
potent(GroundPoints) = V0;                                  % set  boundary condition for ground points

% Allocate memory
telm =  zeros(3,3);
selm = zeros(3,3);
RHS = zeros(nodes,1);
S = zeros(nodes,nodes);
S = sparse(S);


%% obtain stiffness matrices as a Laplacian Problem and calculate Poisson's RHS for each element 
for n = 1:nelements
    ii = nelematrix(n,1);
    jj = nelematrix(n,2);
    kk = nelematrix(n,3);
    ll = 0;
    
    % Calculate the area current element
    area = ((x(jj)-x(ii)).*(y(kk)-y(ii)) - (x(kk)-x(ii)).*(y(jj)-y(ii)))/ 2.0;
    
    theta = TRIangles([x(ii) y(ii); x(jj) y(jj); x(kk) y(kk)]);
        
    % Calculate S-element for an individual element
    for i = 1:6
       for j = 1:6
           temp =0;
           for q = 1:3
               if  q == 1; Qt(1:6, 1:6, q) = (1/6).*Q(1:6, 1:6, 1);
               else Qt(1:6, 1:6, q) = R * Qt(1:6, 1:6, (q-1)) * R';
               end
               Qtemp = Qt(1:6, 1:6, q);
               temp = temp + Qtemp(i,j)*cotd(theta(q));
           end
           selm(i,j, n) = temp;
       end       
   end

    
    rho = getDensity(MeshData.xCentroids(n), MeshData.yCentroids(n), rhoType);
    Pe(n, 1) = (rho*area)./ (3*epsilon);                     % calculate Poisson's RHS for each element
    te(1:6, 1:6, n) = (area/180) .* T;
    
    % Assemble the Global RHS for BC
    for l = 1:3
        irow = nelematrix(n,l);
        if constr(irow) == 1                            % If it is a constrainted node
            RHS(irow) = potent(irow);                   % RHS will be the potential
        end % if constr(irow) == 1
    end
end


%% calculate global Poisson's RHS from global nodes
% P = zeros(nodes, 1);                                         % initialize Poisson's RHS
% for gnode = 1:nodes                                          % loop through the global nodes
%     [eleID, localID] = getElementIndices(MeshData, gnode);   % get list of elements that share a node
%     totalEle = length(eleID);                                % number of elements sharing a node
%     for ei = 1:totalEle                                      % loop through each element sharing the node
%         if constr(gnode) ~= 1
%         P(gnode) = P(gnode) + Pe(eleID(ei));                 % add element's Poisson's RHS already calculated together
%         end
%     end
% end

%% add global Poisson's RHS to already calculated RHS of the Laplacian solutions
% RHS = RHS + P;
% 
% %% Invert using the backslash operator
% phi = S\RHS;
% E = -gradient(phi);


%% Plot the solution
% figure(1)
% trisurf(nelematrix,x,y,phi)
% zlabel('Potential (V)');
% ylabel('y-axis');
% xlabel('x-axis');
% view(2);
% colorbar;
% shading interp; 
% hold
% set(gcf,'render','zbuffer');