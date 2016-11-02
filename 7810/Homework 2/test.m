clear; clc; close all;

% nodeG(:, :) = [0.8 1.8; 1.4 1.4; 2.1 2.1; 1.2 2.7];
nodeG(:, :) = [1.5 1.6; 2 1; 3 2.5; 2 2.4];
el(:,:,1) = [nodeG(1, :); nodeG(2, :); nodeG(4, :)];
el(:,:,2) = [nodeG(2, :); nodeG(3, :); nodeG(4, :)];
nodes = length(nodeG);

for k = 1 : 2
    %% set parameters
    x1 = el(1,1,k);
    y1 = el(1,2,k);
    x2 = el(2,1,k);
    y2 = el(2,2,k);
    x3 = el(3,1,k);
    y3 = el(3,2,k);

    %% calculate needed parameters
    P(1) = (y2 -y3);
    P(2) = (y3 - y1);
    P(3) = (y1 - y2);
    Q(1) = (x3 - x2);
    Q(2) = (x1 - x3);
    Q(3) = (x2 - x1);

    A = 0.5*((P(2)*Q(3)) - (P(3)*Q(2)));

    for i = 1 : 3
        for j = 1 : 3
            c(i,j, k) = (1/(4*A))*((P(i)*P(j)) + (Q(i)*Q(j)));
        end
    end
    c(:, :, k)
    
    %% assemble and update the global matrix
    
end