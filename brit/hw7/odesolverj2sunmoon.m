% Run comparekepler_ode.m %
function [t, y] = odesolverj2sunmoon(ra, rp, Omega, i, w, nu,tspan)

gmu = 3.986004328969392e+05;

% Calculated elements
a = (ra + rp)/2;        % km, semi-major axis
e = (ra-rp)/(ra+rp);    % eccentricity
p = a * (1 - e^2);
r = p / (1 + e*cos(nu));

% Vector transformation
R0 = r.*[cos(nu); sin(nu); 0];
V0 = sqrt(gmu/p).*[-sin(nu); e+cos(nu); 0];

% Input Vectors
R = rotatez(Omega)*rotatex(i)*rotatez(w)*R0;
V = rotatez(Omega)*rotatex(i)*rotatez(w)*V0;
%[R,V] = coe2rv(a, e, i, 0,0,0,0,0,0);
% ODE settings
opts = odeset('Reltol',1e-15,'AbsTol',1e-15,'Stats','on');

b1 = R.';  % Convert to row vector
b2 = V.';
y0 = [b1; b2];
y0 = y0(:)';

[t,y] = ode113(@integratorj2sunmoon, tspan, y0, opts);
end
