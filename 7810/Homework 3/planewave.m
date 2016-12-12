%simple function to compute plane wave values at given points where the 
%waveform is a Gaussian function.
% inputs: x -vector of x-coordinates of points
%         y -vector of y-coordinates of points
%         velocityVec -velocity vector giving direction and velocity
%                      (magnitude) of plane wave.
%         time -propagation time
%         shift -plane wave shifted from origin by this amount
% returns: y -amplitudes at given points for given time, velocity vector
%             and shift

function y = planewave(x, y, velocityVec, time, shift)

v = velocityVec;

%use velocity vector to determine which equivalent points to evaluate
c0 = sqrt(v(1)^2 + v(2)^2);
points = ((v(1) .* x) + (v(2) .* y)) ./ (c0^2);
points = time - points;

%apply shift from origin
a = shift * 1e-9;

%Gaussian 
y = exp(-((points-a).^2*1e21));
