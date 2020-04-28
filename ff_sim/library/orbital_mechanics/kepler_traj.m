function [r,f,x,y] = kepler_traj(a,e,mu_E,tvec)
% Purpose:
%   This function computes the 2D trajectory of Keplarian orbital dynamics
%   given semi-major axis (a), eccentricity (e), gravitational consstnatn
%   (mu_E) and the time.
%
% Input:
% - a:      semi-major axis [m]
% - e:      eccentricity [-]
% - mu_E:   gravitaitonal constant of the planet [m^3/s^2]
% - tvec:   time vector [sec]
%
% Ref:
% [1] Prussing, John E., and Bruce A. Conway. Orbital mechanics. Oxford
%     University Press, USA, 1993.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


n = sqrt(mu_E/a^3);     % mean motion
M = n*tvec;             % mean anomaly
E = kepler_M2E(M,e);    % eccentric anomaly Eq 2.13 in Ref [1]
f = kepler_E2f(E,e);    % true anomaly Eq 2.11 in Ref [1]
r = kepler_E2r(E,a,e);  % radius Eq 2.12 in Ref [1]

x = r.*cos(f);
y = r.*sin(f);

end

