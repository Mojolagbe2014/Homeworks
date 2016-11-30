function [Pi] = rcm(A)
%% rcm.m 
%   Implements Reverse Cuthill-McKee (RCM) Ordering of
%       adjacency graph traversal reordering permutation 
%
%       Parameters:
%           A:      A sparse matrix in compressed-row format with each row sorted
%       Returns:
%            Pi:    A permutation list based on the ordering of the vertices traversed
%
%   Author: Jamiu Babatunde Mojolagbe

    %% obtain the dimension of A inorder to obtain number of rows
    [r, n, m] = getLowestDegree(A)                      % get rows and cols of A and rows of lowest degree of freedom
    i = min(r);                                         % use the lowest row index
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
                    count = count + 1;
                end   
            end
        end
        Pi = [Pi Snew];
        S = Snew;                                       % update level set
    end    
    Pi = fliplr(Pi);
end

