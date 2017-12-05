function [color] = rule(left, me, right, ruleset)
 switch(ruleset)
     case 90;  rules = [0 1 0 1 1 0 1 0];
     case 30;  rules = [0 1 1 1 1 0 0 0]; 
     case 110; rules = [0 1 1 1 0 1 1 0];
     case 190; rules = [0 1 1 1 1 1 0 1];
     case 222; rules = [0 1 1 1 1 0 1 1];
     case 500; rules = [1 0 1 0 1 0 1 0];
     case 91;  rules = [0 1 1 0 0 1 1 0];
     otherwise;rules = [0 1 0 1 1 0 1 0];
 end
 
 map   = [0 1 2 3 4 5 6 7];
 val = strcat(num2str(left), num2str(me), num2str(right));
 d_val = bin2dec(val);
 [index] = find(map == d_val);
 color = rules(index);

end

