function xdot = eomOrbit2d(t,x,grav_param)
% Purpose: comptue the equation of motoion for 2 body problem
% Input:
% - t:      NOT USED. place holder needed for ode45
% - x:      state of object in planetary orbit [4x1]  where
%               x' = [pos_I_I' vel_I_I']
%           where
%               pos_I_I: position from ECI expressed in ECI (m) [2x1]
%               vel_I_I: velocity from ECI expressed in ECI (m/s) [2x1]
% - grav_param: standard gravitational parameter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

velDot = -grav_param/norm(x(1:2))^3*x(1:2);
xdot = [x(3:4); velDot];

end