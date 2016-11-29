function [Pi] = bfs(A, i)
%% bfs.m 
%   Implements Breadth First Search for 
%       adjacency graph traversal reordering permutation 
%
%       Parameters:
%           A:      A sparse matrix in compressed-row format with each row sorted
%           i:      An index of the first vertex (row) to start at
%       Returns:
%            Pi:    A permutation list based on the ordering of the vertices traversed
%
%   Author: Jamiu Babatunde Mojolagbe

    %% obtain the dimension of A inorder to obtain number of rows
    [n, m] = size(A);                                   % obtain the number of rows and cols of A
    Pi = [i];                                           % permutation with starting vertex
    count = 1;                                          % initialize counter for the visited nodes
    marked = zeros(n, 1);                               % keep track of the visited nodes
    marked(i) = 1;                                      % mark vertex i has visited 
    S = [i];                                            % initialize level set
    [IA, JA] = csr(A);
    
    while count < n 
        Snew = [];                                      % new empty level set
        
        for i = S                                       % for each node in current level set
            row_start = IA(i);
            row_stop = IA(i+1);
            
            % loop over the adjacency nodes
            for j = row_start:row_stop - 1
                column = JA(j);
                if marked(column) == 0 
                    marked(column) = 1;
                    Snew = [Snew column];
                    Pi = [Pi column];
                    count = count + 1;
                end   
            end
        end
        S = Snew;                                       % update level set
    end    
end

