function density = getDensity(x, y, type)
    switch type
        case 0; density = 1;
        case 1; density = 100*exp(-((100*x*x) + (100*y*y)));
        case 2; density = 1 + 4*(x.^2);
        case 3; density = ((exp(-x))*(y.^(ceil(abs(x))))/factorial((floor(abs(x)))));
        case 4; density = (((exp(-x))*(y.^(ceil(abs(x)))) + ((exp(-y))*(x.^(ceil(abs(y))))))/factorial((floor(abs(x)))));
        case 5; density = x*(y-1);
    end
        
end