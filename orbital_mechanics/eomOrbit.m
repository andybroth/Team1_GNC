function xdot = eomOrbit(t,x,grav_param)
% Purpose: comptue the equation of motoion for 2 body problem
% Input:
% - t:      NOT USED. place holder needed for ode45
% - x:      state of object in planetary orbit [6x1]  where
%               x' = [pos_I_I' vel_I_I']
%           where
%               pos_I_I: position from ECI expressed in ECI (m) [3x1]
%               vel_I_I: velocity from ECI expressed in ECI (m/s) [3x1]
% - grav_param: standard gravitational parameter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% point mass gravity force
f_pt_mass = -grav_param/norm(x(1:3))^3*x(1:3);

% --- TODO: implement these -----
f_drag = zeros(3,1);    % aerodynamic drag (high priority)
f_j2   = zeros(3,1);      % J2 (high priority)
% f_shg  = zeros(3,1);    % spherical harmonic gravity (high priority)
% f_srp  = zeros(3,1);    % solar radiation pressure
% f_tide = zeros(3,1);    % solid earth tidal force 



% add all forces
velDot = f_pt_mass + f_drag + f_j2;
xdot = [x(4:6); velDot];

end