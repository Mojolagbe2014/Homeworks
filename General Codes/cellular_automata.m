clear; clc; close all;
x = 300;
t = 300;
ruleset = 30; % 30 | 90 | 110 | 190 | 222
wait = 0.05;


gen = zeros(1, x);
gen(1, floor(x/2)) = 1;
% gen(1, 2) = 1;

% for ii = 1:t
%     imagesc(gen)
%     pause(wait)
%     for jj = 2:x-1
%         left = gen(ii, jj - 1);
%         right = gen(ii, jj + 1);
%         me    = gen(ii, jj);
%         gen(ii+1, jj)  = rule(left, me, right, ruleset);
%     end
% end

for ii = 1:t -1
    imagesc(gen)
    pause(wait)
    for jj = 1:x
        if(jj == 1)
            left = gen(ii, x);
            right = gen(ii, jj + 1);
        elseif(jj == x)
            left = gen(ii, jj - 1);
            right = gen(ii, 1);
        else
            left = gen(ii, jj - 1);
            right = gen(ii, jj + 1);
        end
        me    = gen(ii, jj);
        gen(ii+1, jj)  = rule(left, me, right, ruleset);
    end
end

% imagesc(gen),
% colormap hot


