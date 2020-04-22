function [r, te, ye, ie] = int_orbit(init, a, T)
% Will integrate given initial conditions over many orbital period
% Ideally returns position after each orbit to track drift

% Solves the J2 EOM
% init - initial position and velocity vectors in the form: 
%        rx, ry, rz, vx, vy, vz
% radius - radius of the orbit
% a - semi-major axis

hw1a;

tspan = [0,T]; %Time span for ode solver

mag = @(r) sqrt(r(1)^2+r(2)^2+r(3)^2); %calculates magnitude of r
xpp = @(r) -(gmu*r(1)/(norm(r(1:3)))^3)*(1-(EARTH.j2*3/2*(EARTH.radius/norm(r(1:3)))^2*(5*(r(3)/norm(r(1:3)))^2-1)));
zpp = @(r)-gmu*r(3)/mag(r).^3*(1+EARTH.j2*1.5*(EARTH.radius/mag(r)).^2*(3-5*(r(3)/mag(r)).^2));
f = @(t,r) [r(4:6); xpp(r); r(2)*xpp(r)/r(1); zpp(r)]; %dif equation

options = odeset('AbsTol', 10e-15, 'Event', @event_function);
[t,r, te, ye, ie] = ode113(f, tspan, init, options);

end