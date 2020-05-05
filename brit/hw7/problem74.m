%% Spacecraft visibility from the station
% Positioned from 0 deg longitude, elevation angle 0 deg

% Latitude of crossing at Node 0

d = 3;
n = 16;
we = 7.2921150*10^-5;
j2 = 1.8262668*10^-3;
gmu = 3.986004328969392*10^5;
inc = 70*pi/180;
re = 6.378136000000000*10^3;

a = ((d/n)*(sqrt(gmu)/we))^(3/2);

phi0 = 0;
theta0 = acos(re/a);
eta = 0;
Li = inc;
phi1 = -inc;
phi2 = inc;



syms p
f = cos(p)*acos((cos(theta0) - sin(p)*sin(phi0))/(cos(phi0)*cos(p)))/(pi^2*sqrt(sin(inc)^2 - sin(p)^2));
rho = int(f, phi1, phi2)
