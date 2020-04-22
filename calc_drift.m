% Main file to run which will provide plot of drift vs. orbit #
clear all;
close all;

setearth;
%%

gmu = EARTH.gm;
r = EARTH.radius;
alt = 400; % orbit is 400km above earth

% Use init_PRO to get initial conditions
x0 = 50; % set x0, will loop through later to see how distances change things
ri = [x0;0;0]; % in LVLH frame, this initialization is arbitrary
rvi = init_PRO(gmu, ri, r+alt);
fprintf('Delta v required: %s\n',norm(rvi(4:6)));

% Use int_orbit to integrate orbit
rvt = int_orbit(rvi, t, gmu, r+alt);

% Create plots below