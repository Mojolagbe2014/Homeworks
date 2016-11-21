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
V1 = 100;                                                   % probe potential
rhoType = 5;                                                % source excitation variations - has values [0|1|2|3|4]
MeshData = GmshReadM('mesh_files/flat_plate.msh');          % Use GmshreadM to read the Gmsh mesh file
nodes = MeshData.nNodes;                                    % the number of nodes
x = MeshData.xNodes;                                        % the x-coordinate of the nodes
y = MeshData.yNodes;                                        % the y-coordinate of the nodes
epsilon = 1.5;                                             % permittivity of the dielectric material
nodes_matrix = [MeshData.NodesID(:) x(:) y(:)];             % create the nodes matrix
nelements = MeshData.nElements;                             % obtain the total number of elements
nelematrix = MeshData.EleMatrix;                            % elements with corresponding 3 global nodes


% create extra points on each of the elements
for n = 1:nelements
    ii = nelematrix(n,1);
    jj = nelematrix(n,2);
    kk = nelematrix(n,3);
    
    addNod1X = (x(ii) + x(jj))/2;
    addNod1Y = (y(ii) + y(jj))/2;
    addNod2X = (x(jj) + x(kk))/2;
    addNod2Y = (y(jj) + y(kk))/2;
    addNod3X = (x(ii) + x(kk))/2;
    addNod3Y = (y(ii) + y(kk))/2;
    
    pt = [addNod1X, addNod1Y];
    xyofnmatrix = nodes_matrix(:, 2:3);
    [~,index] = ismember(pt,xyofnmatrix,'rows');
    if index ~= 0
        temp = nelematrix(n,2);
        nelematrix(n,2) = index;
        nelematrix(n,4) = temp;
    else
        temp = nelematrix(n,2);
        nodes = nodes + 1;
        nelematrix(n,2) = nodes;
        nelematrix(n,4) = temp;
        x(nodes) = addNod1X;
        y(nodes) = addNod1Y;
        nodes_matrix = [nodes_matrix; [nodes pt]];
    end
    
    pt = [addNod2X, addNod2Y];
    xyofnmatrix = nodes_matrix(:, 2:3);
    if index ~= 0
        nelematrix(n,5) = index;
    else
        nodes = nodes + 1;
        nelematrix(n,5) = nodes;
        x(nodes) = addNod2X;
        y(nodes) = addNod2Y;
        nodes_matrix = [nodes_matrix; [nodes pt]];
    end
    
    pt = [addNod3X, addNod3Y];
    xyofnmatrix = nodes_matrix(:, 2:3);
    if index ~= 0
        temp = nelematrix(n,3);
        nelematrix(n,3) = index;
        nelematrix(n,6) = temp;
    else
        temp = nelematrix(n,3); nodes = nodes + 1;
        nelematrix(n,3) = nodes;
        nelematrix(n,6) = temp;
        x(nodes) = addNod3X;
        y(nodes) = addNod3Y;
        nodes_matrix = [nodes_matrix; [nodes pt]];
    end
end  

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
Tg = zeros(nodes,nodes);
Tg = sparse(Tg);

%% obtain stiffness matrices as a Laplacian Problem and calculate Poisson's RHS for each element 
for n = 1:nelements
    ii = nelematrix(n,1);
    ij = nelematrix(n,2);
    ki = nelematrix(n,3);
    jj = nelematrix(n,4);
    jk = nelematrix(n,5);
    kk = nelematrix(n,6);
    
    % Calculate the area current element
    area = MeshData.TriangleArea(n);
    
    theta = TRIangles([x(ii) y(ii); x(ij) y(ij); x(kk) y(kk)]);
    % Calculate S-element for an individual element
%     iarr1 = [1, 4, 6]; iarr2 = [1, 2, 6]; iarr3 = [3, 4, 1];
    for i = 1:6
       for j = 1:6
%            if ~isempty(find(iarr1, i)) && ~isempty(find(iarr1, j)) 
%                theta = TRIangles([x(ii) y(ii); x(jj) y(jj); x(kk) y(kk)]);
%            end
%            if ~isempty(find(iarr2, i)) && ~isempty(find(iarr2, j)) 
%                theta = TRIangles([x(ii) y(ii); x(ij) y(ij); x(kk) y(kk)]);
%            end
%            if ~isempty(find(iarr3, i)) && ~isempty(find(iarr3, j)) 
%                theta = TRIangles([x(jj) y(jj); x(ki) y(ki); x(kk) y(kk)]);
%            end
           selm(i,j) =0;
           for q = 1:3
               if  q == 1; Qt = (1/6).*Q;
               else Qt(1:6, 1:6, q) = R * (Qt(1:6, 1:6, (q-1)) * R');
               end
               selm(i,j) = selm(i,j) + Qt(i,j, q)*cotd(theta(q));
           end
           
       end       
   end
    
    
    
    rho = getDensity(MeshData.xCentroids(n), MeshData.yCentroids(n), rhoType);
    Pe(n, 1) = (rho*area)./ (3*epsilon);                     % calculate Poisson's RHS for each element
    telm(1:6, 1:6) = (area/180) .* T;
    
    % Assemble the Global RHS for BC
    for l = 1:6
        irow = nelematrix(n,l);
        if constr(irow) == 1                            % If it is a constrainted node
            S(irow,irow) = 1;                           % add a 1 to the diagonal on the irow row
            RHS(irow) = potent(irow);                   % RHS will be the potential
        else                                            % If it is a free node       
            for m = 1:6                                 % go around the other nodes if it is a free node
                icol = nelematrix(n,m);
                if constr(icol) == 1
                    RHS(irow) = RHS(irow) - selm(l,m).*potent(icol);
                    Tg(irow,icol) = Tg(irow,icol) + telm(l,m);
                else
                    S(irow,icol) = S(irow,icol)+selm(l,m); 
                    Tg(irow,icol) = Tg(irow,icol) + telm(l,m);
                end % if constr(icol) == 1
            end % For m
        end % if constr(irow) == 1
    end
end


% calculate global Poisson's RHS from global nodes
P = zeros(nodes, 1);                                         % initialize Poisson's RHS
for gnode = 1:nodes                                          % loop through the global nodes
    [eleID, localID] = getElementIndices(nelematrix, gnode);   % get list of elements that share a node
    totalEle = length(eleID);                                % number of elements sharing a node
    for ei = 1:totalEle                                      % loop through each element sharing the node
        if constr(gnode) ~= 1
        P(gnode) = P(gnode) + Pe(eleID(ei));                 % add element's Poisson's RHS already calculated together
        end
    end
end

%% add global Poisson's RHS to already calculated RHS of the Laplacian solutions
RHS = RHS + (Tg*P);

%% Invert using the backslash operator
phi = S\RHS;
E = -gradient(phi);


% Plot the solution
figure(1)
trisurf(MeshData.EleMatrix,x,y,phi)
zlabel('Potential (V)');
ylabel('y-axis');
xlabel('x-axis');
view(2);
colorbar;
shading interp; 
hold
set(gcf,'render','zbuffer');