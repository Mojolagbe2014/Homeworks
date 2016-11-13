clear;clc;
load('data/Q.mat')
load('data/R.mat')
load('data/T.mat')

% Use GmshreadM to read the Gmsh mesh file
MeshData = GmshReadM('mesh_files/flat_plate.msh');

nodes = MeshData.nNodes;    % the number of nodes
x = MeshData.xNodes;        % the x-coordinate of the nodes
y = MeshData.yNodes;        % the y-coordinate of the nodes

% create the nodes matrix
nodes_matrix = [MeshData.NodesID(:) x(:) y(:)];

% create
nelements = MeshData.nElements;
nelematrix = MeshData.EleMatrix;


%Distribute a charge over each element at its centroid
xcent = MeshData.xCentroids;   % the x-coordinate at centroids of each element
ycent = MeshData.yCentroids;   % the y-coordinate  at centroids of each element

% Constraint and Potential Vector for the boundary nodes
 
constr = zeros(nodes,1);  % Constraint identification vector, will be set
                          % to 1 if the node is a Dirichlet node
potent = zeros(nodes,1);  % Solution vector, this is what is solved for
 
% Setting the constraint vector equal to one for boundary values
% MeshData.BdNodes contains the indices of the boundary nodes
constr(MeshData.BdNodes) = 1;
 
% Setting the boundary conditions based on the Line Physics
% get the lines having LinePhysics == 101
% and store the list of points on the line in ProbePoints
tmp = find(MeshData.LinePhysics == 101);
ProbePoints1 = unique(MeshData.LineMatrix(tmp,:));
% Grounded Points
% and store the list of points on the line in GroundPoints
tmp = find(MeshData.LinePhysics == 100) ;
GroundPoints = unique(MeshData.LineMatrix(tmp,:));

% Set the value of the potential appropriately
potent(ProbePoints1) = 100;
potent(GroundPoints) = 0; 



R_perm(nelements,1) = 0;
perm(nelements,1)   = 0;
S_perm=8.9*10^-12;
c_density(1:nelements,1) = 0;
p_element(nelements,1)   = 0;
p_global(nodes,1)        = 0;

for n = 1:nelements
    %----------------------------------
    c_density(n,1)=100*exp(-(100*xcent(n)^2+100*ycent(n)^2));
    R_perm(n,1)= 1+(10-1)*rand();
    perm(n,1)=R_perm(n,1)*S_perm;
    %---------------------------------------------
end
for n  = 1:nelements
    
    ii = nelematrix(n,1);
    jj = nelematrix(n,2);
    kk = nelematrix(n,3);
    
    % Calculate the area current element
    area = ( (x(jj)-x(ii)).*(y(kk)-y(ii)) - (x(kk)-x(ii)).*(y(jj)-y(ii)))/ 2.0;
    
     
   % Calculate angle of each vertex
   d1 = sqrt(abs(x(ii)-x(jj))^2+abs(y(ii)-y(jj))^2);
   d2 = sqrt(abs(x(ii)-x(kk))^2+abs(y(ii)-y(kk))^2);
   d3 = sqrt(abs(x(kk)-x(jj))^2+abs(y(kk)-y(jj))^2);
   d  = [d1 d2 d3];
   b  = max(d);
   a  = min(d);
   if d1~=max(d)&&d1~=min(d)
       c=d1;
   end
   if d2~=max(d)&&d2~=min(d)
       c=d2;
   else
       c=d3;
   end
   t1 = acosd(((a^2+c^2)-b^2)/2*a*c); %use cos rule to find the largest angle
   t2 = asind((c*sin(b))/b);          %Use sin rule 
   t3 = 180-(t1+t2);                  %Use sum of internal angles rule 
   t(n,1:3)  = [t1 t2 t3]; 
   
   for i = 1:6
       for j = 1:6
           temp =0;
           for q = 1:3
               Qtemp = Q(:,:,:,:,:,:,q);
               temp = temp + Qtemp(i,j)*cotd(t(n, q));
           end
           S(i,j, n) = temp;
       end       
   end

end

