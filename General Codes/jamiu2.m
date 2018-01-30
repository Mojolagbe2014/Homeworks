clear; close all; clc;

x = 1;
n = 15;
incr = 1;
inc = 1;
start = 1;
wait = 0.8;
repeat = 100;

for time = 1:repeat
col = 2*(n+1) - 1;
xloc = ceil(col/2);
X = zeros(1, col);
% X = zeros(n+1, col);
X(1, xloc) = x;



for i = 1:incr:n
    col_incr = 2;
    switch(mod(n, 2))
        case 0;
            if(mod(i, 2) == 0); col_start = 2;
            else col_start = 3; end
        otherwise;
            if(mod(i, 2) == 0); col_start = 3;
            else col_start = 2; end
    end
    
    X(i+1, :) = 0;
    for j = col_start:col_incr:col
        if(j > 1 && j < col)
            X(i+1, j-1) =  X(i+1, j-1) + X(i, j) - inc;
            X(i+1, j+1) =  X(i+1, j+1) + X(i, j) + inc;
        end
    end
    imagesc(X),
    colormap hot
    axis off
    pause(wait)
end

sum(X(end,:))

end