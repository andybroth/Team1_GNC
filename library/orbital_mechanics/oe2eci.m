function [r_ECI,v_ECI] = oe2eci(a,e,inc,omega,Omega,nu,mu_p)
% Purpose: 
%   This function converts from orbital elements to position and
%   velocity in planet centric inertial frame (e.g. ECI) .
%
% Input:
% - a:      semi-major axis
% - e:      eccentricity
% - inc:    inclination  (rad)
% - omega:  argument of perigee  (rad)
% - Omega:  RAAN  (rad)
% - nu:     (rad)
% - mu_p
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = a*(1-e^2);
r = p/(1+e*cos(nu));
v = sqrt(mu_p*(2/r-1/a));
h = sqrt(p*mu_p);
hrv = h/r/v;
if abs(hrv) > 1
    hrv = sign(hrv);
end
gamma = asin(hrv);

r_peri = r*[cos(nu) sin(nu) 0]';
v_peri = v*[-cos(pi-gamma-nu) sin(pi-gamma-nu) 0]';

ci = cos(inc);
si = sin(inc);
cw = cos(omega);
sw = sin(omega);
co = cos(Omega);
so = sin(Omega);

Q_peri_to_ECI = [-so*ci*sw+co*cw  -so*ci*cw-co*sw   so*si;
                  co*ci*sw+so*cw   co*ci*cw-so*sw  -co*si;
                  si*sw            si*cw            ci];

r_ECI = Q_peri_to_ECI*r_peri;
v_ECI = Q_peri_to_ECI*v_peri;

end