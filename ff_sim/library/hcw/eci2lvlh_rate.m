function [omega_L_I] = eci2lvlh_rate(posRef_I_I,velRef_I_I)
% Purpose:
%   Compute angular rate of LVLH frame from position and velocity in
%   inertial frame (e.g. ECI)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

angMom = cross(posRef_I_I,velRef_I_I);
omega_L_I = angMom/norm(posRef_I_I)^2;

end


