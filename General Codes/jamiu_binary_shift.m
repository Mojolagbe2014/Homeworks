%% Shifting Algorithm Implementation
%  Author: Jamiu Babatunde Mojolagbe
%  Date: 26th January, 2019.


% clear and close open graphs
clear; close all; clc;

%% set parameters
x = 1;          % Root
n = 5;          % Power
inc = 1;        % Shifting Increment - it can be any value other than 0
wait = 0.8;     % Animation Speed
repeat = 1;     % Animation Repeatition
color = [-1 1];

for time = 1:repeat
    %% allocate matrix memory & find the center of the column
    col = 2*(n+1) - 1;
    xloc = ceil(col/2);
    X = zeros(1, col);
    %X = zeros(n+1, col);   % pre allocate memory
    X(1, xloc) = x;
    active = xloc;

    %% evaluate the shifting algorithm for base 2 (right/left shift only)
    for i = 1:n
        X(i+1, :) = 0;
        tempActive = active;
        for j=1:length(active)
            right = active(j) + 1;
            left = active(j) - 1;
            X(i+1, left) =  X(i+1, left) + X(i, active(j)) - inc;
            X(i+1, right) =  X(i+1, right) + X(i, active(j)) + inc;
            tempActive(j) = left;
            tempActive(j+1) = right;
        end
        active = tempActive;
        % show animation
        %spy(X)
        imagesc(X)
        caxis(color);
        colormap hot
        axis off
        pause(wait)
    end

    %% sum the matrix entry and display the result
    sum(X(end,:))

end