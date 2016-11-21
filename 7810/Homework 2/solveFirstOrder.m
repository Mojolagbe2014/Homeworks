function [phi] = solveFirstOrder(MeshData,V1, rhoType, epsilon, sides)
%solveFirstOrder.m 
%   Computes scalar potential,phi(x,y) on a rectangular grid
%   using First Order Solution (Poisson's Problem)
%
%       Parameters
%           MeshData:   Returned object from ReadGMSH function
%           V1:         Applied potential
%           rhoType:    Source distribution type
%           epsilon:    Relative permittivity of the medium
%           sides:      Boundaries line physics
%       
%       Returns
%           phi:        Potential distribution as column vector
%        
%       Course:     ECE 7810
%       Homework:   2
%       Sub. Date:  November 3, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

    %% set parameters
    nodes = MeshData.nNodes;                                    % the number of nodes
    x = MeshData.xNodes;                                        % the x-coordinate of the nodes
    y = MeshData.yNodes;                                        % the y-coordinate of the nodes
    nelements = MeshData.nElements;                             % obtain the total number of elements
    nelematrix = MeshData.EleMatrix;                            % elements with corresponding 3 global nodes

    constr = zeros(nodes,1);                                    % Constraint identification vector, will be set
                                                                % to 1 if the node is a Dirichlet node
    potent = zeros(nodes,1);                                    % Solution vector, this is what is solved for
    constr(MeshData.BdNodes) = 1;                               % Set constraint vector equal to one for boundary values

    tmp = find((MeshData.LinePhysics == sides(4)) );
    ProbePoints = unique(MeshData.LineMatrix(tmp,:));           % set probe points
    tmp = find((MeshData.LinePhysics == sides(1)) | (MeshData.LinePhysics == sides(2)) | (MeshData.LinePhysics == sides(3)));
    GroundPoints = unique(MeshData.LineMatrix(tmp,:));          % set ground points

    potent(ProbePoints) =  V1;                                  % set  boundary condition for probe points
    potent(GroundPoints) = 0;                                   % set  boundary condition for ground points
    
    %% Allocate memory
    RHS = zeros(nodes,1);
    S = zeros(nodes,nodes);
    
    %% obtain stiffness matrices as a Laplacian Problem and calculate Poisson's RHS for each element 
    for n = 1:nelements
        % Form stiffness and mass matrices, selm and telm, for each element   
        CNTG = 0;
        selm = zeros(3,3);

        ii = nelematrix(n,1);
        jj = nelematrix(n,2);
        kk = nelematrix(n,3);

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

        rho = getDensity(MeshData.xCentroids(n), MeshData.yCentroids(n), rhoType);
        Pe(n, 1) = (rho*area)./ (3*epsilon);                     % calculate Poisson's RHS for each element

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


    %% calculate global Poisson's RHS from global nodes
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
    RHS = RHS + P;

    %% Invert using the backslash operator
    phi = S\RHS;
end

