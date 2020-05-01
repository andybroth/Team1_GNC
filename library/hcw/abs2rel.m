function [pos_r_r,vel_r_r] = abs2rel(pos_i_i, vel_i_i,rot_r_i,angRate_r_i,pos_ref_i_i,vel_ref_i_i)
% Purpose:
%   This function computes the relative position and velocity of an object
%   (e.g. a spacecraft) with respect to the rotating frame. The inputs are
%   the absolute positions and velocities of the object and the reference
%   frame.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% relative pos/vel in inertial frame
relPos_r_i = pos_i_i - pos_ref_i_i;
relVel_i_i = vel_i_i - vel_ref_i_i;

% compute the relative position and relative velocity in inertial frame
[pos_r_r,vel_r_r] = inert2rot(relPos_r_i,relVel_i_i,rot_r_i,angRate_r_i);



end



