function [r,v] = kepler_prop(r0,v0,t0,t,mu_E)
% Purpose:
%   This function propagates the 2D position and velocity of satellite at
%   t0 to t using Keplarian orbital mechanics.
%
% Ref:
% [1] Prussing, John E., and Bruce A. Conway. Orbital mechanics. Oxford
%     University Press, USA, 1993. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rnorm0 = norm(r0);
vnorm0 = norm(v0);
h0 = r0(1)*v0(2)-r0(2)*v0(1);

a = 1/(2/rnorm0-vnorm0^2/mu_E);     % Eq 2.36 in Ref [1]
e = sqrt(1-h0^2/mu_E/a);            % eccentricity
n = sqrt(mu_E/a^3);                 % mean motion
trueAnom0 = atan2(r0(2),r0(1));     % true anomaly
E0 = kepler_f2E(trueAnom0,e);       % initial eccentric anomaly
E = kepler_t2E(t0,E0,t,e,n);        % final eccentric anomaly

f = 1-a/rnorm0*(1-cos(E-E0));                   % eq 2.26
g = (t-t0)-sqrt(a^3/mu_E)*((E-E0)-sin(E-E0));   % eq 2.29

r = f*r0+g*v0;

rnorm = norm(r);

fdot = -sqrt(mu_E*a)/rnorm/rnorm0*sin(E-E0);
gdot = 1-a/rnorm*(1-cos(E-E0));

v = fdot*r0+gdot*v0;

end

