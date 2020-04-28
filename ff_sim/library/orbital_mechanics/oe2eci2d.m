function [r0,v0] = oe2eci2d(a,e,f0,mu_E)
% Purpose:
%   This function computes state vector (position and velocity) given
%   orbital elements.
%
% Input:
% - a:
% - e:
% - f0:     true anomaly at t0
% - mu_E:   earth graviational constant
%
% Output:
% - r0:     position vector
% - v0:     velocity vector
%
% Ref:
% [1] Prussing, John E., and Bruce A. Conway. Orbital mechanics. Oxford
%     University Press, USA, 1993. 
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


E0 = kepler_f2E(f0,e);

% Eq 2.24 in Ref[1]
r0 = a*[cos(E0)-e;
        sqrt(1-e^2)*sin(E0)];
r0norm = sqrt(r0(1)^2+r0(2)^2);
v0 = sqrt(mu_E*a)/r0norm*[-sin(E0); sqrt(1-e^2)*cos(E0)];


end