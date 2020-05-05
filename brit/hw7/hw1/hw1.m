% HOMEWORK 1 
% USE: SET UP CONSTANTS
% Set Earth Constants for Homework 1.
% 
setearth;
gmu = EARTH.gm;  % Earth's gravitational constant for central force equation.

% Get Earth to L1, L2 Distance
lpts = lptall(EARTH.mu);
[RUNIT,TUNIT,jVUNIT,AUNIT]=setunits(EARTH);
lkm = lpts*RUNIT;
RL1 = AU-lkm(1,1);    % Distance from Earth to Sun-Earth L1 in KM
RL2 = lkm(2,1)-AU;    % Distance from Earth to Sun-Earth L2 in KM
ROTD= EARTH.rotD;     % Earth rotation rate Deg/Sec.

% Set Moon Constants
setmoon;
RMOON = MOON.sm;      % Distance of Earth to Moon (Semimajor Axis) in KM



