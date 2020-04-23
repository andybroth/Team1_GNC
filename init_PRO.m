function [rvi] = init_PRO(mu, ri, geo_dist)
% Gives initial conditions for a PRO orbit
r = sqrt(ri(1)^2 + (ri(2)+geo_dist)^2 + ri(3)^2);
wz = sqrt(mu/r^3);


% Linear solution
vi = [0;-2*wz*ri(1);0];

rvi = [ri;vi];