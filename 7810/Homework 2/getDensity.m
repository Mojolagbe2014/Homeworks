function density = getDensity(x, y, type)
%% solveAnalytic 
%   Computes scalar potential,phi(x,y) on a rectangular grid
%   using Analytical Solution (Poisson's Problem)
%
%       Parameters
%           x:      x co-ordinate of a point
%           y:      y co-ordinate of a point
%           type:   excitation type
%       
%       Returns
%           density: charge density
%        
%       Course:     ECE 7810
%       Homework:   2
%       Sub. Date:  November 3, 2016
%
%           Author:     Jamiu Babatunde Mojolagbe
%           Department: Electrical and Computer Engineering
%           Student ID: #7804719
%           Email:      mojolagm@myumanitoba.ca

    switch type
        case 0; density = 1;
        case 1; density = 100*exp(-((100*x*x) + (100*y*y)));
        case 2; density = 1 + 4*(x.^2);
        case 3; density = ((exp(-x))*(y.^(ceil(abs(x))))/factorial((ceil(abs(x)))));
        case 4; density = (((exp(-x))*(y.^((abs(x)))) + (((-y))*(x.^(floor(abs(y))))))/factorial((floor(abs(x)))));
        case 5; density = x*(y-1);
    end 
end