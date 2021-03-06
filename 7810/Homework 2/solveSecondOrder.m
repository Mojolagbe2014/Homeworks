function [phi, MeshData] = solveSecondOrder(MeshData,V1, rhoType, epsilon, sides, Qpath, Rpath, Tpath)
%solveFirstOrder.m 
%   Computes scalar potential,phi(x,y) on a rectangular grid
%   using Second Order Solution (Poisson's Problem)
%
%       Parameters
%           MeshData:   Returned object from ReadGMSH function
%           V1:         Applied potential
%           rhoType:    Source distribution type
%           epsilon:    Relative permittivity of the medium
%           sides:      Boundaries line physics
%           Q|R|Tpath:  Path to the matrices Q, R and T respectively
%
%       Returns
%           phi:    Matrix of potential distribution
%        
%       Course:     ECE 7810
%       Homework:   2
%       Sub. Date:  November 3, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

    %% load given table/matrices
    load(Qpath);
    load(Rpath);
    load(Tpath);
    
    %% set parameters
    nodes = MeshData.nNodes;                                    % the number of nodes
    x = MeshData.xNodes;                                        % the x-coordinate of the nodes
    y = MeshData.yNodes;                                        % the y-coordinate of the nodes
    nelements = MeshData.nElements;                             % obtain the total number of elements
    nelematrix = MeshData.EleMatrix;                            % elements with corresponding 3 global nodes
    nodes_matrix = [MeshData.NodesID(:) x(:) y(:)];
    %% create extra points (second order points) on each of the elements
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
            nodes = nodes + 1;
            if (~isempty(find(MeshData.BdNodes==ii)) && ~isempty(find(MeshData.BdNodes==jj)))
                [~,idx] = ismember([ii jj], MeshData.LineMatrix,'rows');
                if idx == 0; [~,idx] = ismember([jj ii], MeshData.LineMatrix,'rows'); end
                linePhy = MeshData.LinePhysics(idx);
                MeshData.LinePhysics = [MeshData.LinePhysics; linePhy];
                MeshData.LineMatrix = [MeshData.LineMatrix; [nodes, nodes]];
                MeshData.BdNodes = [MeshData.BdNodes; nodes];
            end
            temp = nelematrix(n,2);
            nelematrix(n,2) = nodes;
            nelematrix(n,4) = temp;
            x(nodes) = addNod1X; 
            y(nodes) = addNod1Y; 
            nodes_matrix = [nodes_matrix; [nodes pt]];
        end

        pt = [addNod2X, addNod2Y];
        xyofnmatrix = nodes_matrix(:, 2:3);
        [~,index] = ismember(pt,xyofnmatrix,'rows');
        if index ~= 0
            nelematrix(n,5) = index;
        else
            nodes = nodes + 1;
            if (~isempty(find(MeshData.BdNodes==jj)) && ~isempty(find(MeshData.BdNodes==kk)))
                [~,idx] = ismember([kk jj], MeshData.LineMatrix,'rows');
                if idx == 0; [~,idx] = ismember([jj kk], MeshData.LineMatrix,'rows'); end
                linePhy = MeshData.LinePhysics(idx);
                MeshData.LinePhysics = [MeshData.LinePhysics; linePhy];
                MeshData.LineMatrix = [MeshData.LineMatrix; [nodes, nodes]];
                MeshData.BdNodes = [MeshData.BdNodes; nodes];
            end
            nelematrix(n,5) = nodes;
            x(nodes) = addNod2X; 
            y(nodes) = addNod2Y;
            nodes_matrix = [nodes_matrix; [nodes pt]];
        end

        pt = [addNod3X, addNod3Y];
        xyofnmatrix = nodes_matrix(:, 2:3);
        [~,index] = ismember(pt,xyofnmatrix,'rows');
        if index ~= 0
            temp = nelematrix(n,3);
            nelematrix(n,3) = index;
            nelematrix(n,6) = temp;
        else
            nodes = nodes + 1;
            if (~isempty(find(MeshData.BdNodes==kk)) && ~isempty(find(MeshData.BdNodes==ii)))
                [~,idx] = ismember([kk ii], MeshData.LineMatrix,'rows');
                if idx == 0; [~,idx] = ismember([ii kk], MeshData.LineMatrix,'rows'); end
                linePhy = MeshData.LinePhysics(idx);
                MeshData.LinePhysics = [MeshData.LinePhysics; linePhy];
                MeshData.LineMatrix = [MeshData.LineMatrix; [nodes, nodes]];
                MeshData.BdNodes = [MeshData.BdNodes; nodes];
            end
            temp = nelematrix(n,3); 
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
        ii = nelematrix(n,1);
        jj = nelematrix(n,4);
        kk = nelematrix(n,6);

        % Calculate the area current element
        area = ((x(jj)-x(ii)).*(y(kk)-y(ii)) - (x(kk)-x(ii)).*(y(jj)-y(ii)))/ 2.0;

        theta = TRIangles([x(ii) y(ii); x(jj) y(jj); x(kk) y(kk)]);
        selm = zeros(6, 6);
        for i = 1:6
           for j = 1:6
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

        % Assemble the Global S Matrix
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
                    else
                        S(irow,icol) = S(irow,icol) + selm(l,m); 
                    end % if constr(icol) == 1
                end % For m
            end % if constr(irow) == 1
        end
    end

    S = sparse(S);
    MeshData.EleMatrix1 = MeshData.EleMatrix;               % backup old element matrix
    MeshData.EleMatrix = nelematrix;                        % store the new element matrix (second other ones)
    MeshData.xNodes = nodes_matrix(:, 2);
    MeshData.yNodes = nodes_matrix(:, 3);
    MeshData.NodesID = nodes_matrix(:, 1);

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

