%% Shifting Algorithm Implementation
%  Author: Jamiu Babatunde Mojolagbe
%  Date: 26th January, 2019.
%  Comment: This works for all BASES but uses the same space as binary
%           shifting


% clear and close open graphs
clear; close all; clc;

%% set parameters
a = 1;          % root
b = 7;          % base
c = 300;          % power
inc = 1;        % shifting increment - it can be any value other than 0

% animation settings
animation = 1;  % show animation 
wait = 0.01;     % animation speed
repeat = 1;     % animation repeatition
color = [-1 1]; % animation color scheme

for time = 1:repeat
    %% allocate matrix memory & find the center of the column
    col = 2*(c+1) - 1;
    mid = ceil(col/2);
    if mod(mid, 2) == 0 
        col = col + 1;
        mid = ceil(col/2);
    end
    X = zeros(1, col);
    %X = zeros(c+1, col);   % pre allocate memory
    X(1, mid) = a;
    active = mid;

    %% evaluate the shifting algorithm for base 2 (right/left shift only)
    for i = 1:c
        X(i+1, :) = 0;
        tempActive = active;
        for j=1:length(active)
            for k=1:b
                index = length(tempActive);
                if k==1
                    left = active(j) - 1;
                    X(i+1, left) =  X(i+1, left) + X(i, active(j)) - inc;
                    tempActive(index+1) = left;
                elseif k==b
                    right = active(j) + 1;
                    X(i+1, right) =  X(i+1, right) + X(i, active(j)) + inc;
                    tempActive(index+1) = right;
                else
                    neutral = active(j);
                    X(i+1, neutral) =  X(i+1, neutral) + X(i, active(j));
                    tempActive(index+1) = neutral;
                end
            end
        end
        active = unique(tempActive);
        
        % show animation
        if animation || animation == 1
            %spy(X)
            imagesc(X)
            caxis(color);
            colormap hot
            axis off
            pause(wait)
        end
    end

    %% sum the matrix entry and display the result
    sum(X(end,:))

end