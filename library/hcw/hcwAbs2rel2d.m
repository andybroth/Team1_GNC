function [pos_r_r,vel_r_r] = hcwAbs2rel2d(pos_i_i, vel_i_i,pos_ref_i_i,vel_ref_i_i)
% Purpose:
%   This function computes the relative position and velocity of an object
%   (e.g. a spacecraft) with respect to the rotating frame. The inputs are
%   the absolute positions and velocities of the object and the reference
%   frame.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


rot_r_i = eci2lvlh2d(pos_ref_i_i,vel_ref_i_i);
angRate_r_i = getAngRate2d(pos_ref_i_i,vel_ref_i_i);

% relative pos/vel in inertial frame
relPos_r_i = pos_i_i - pos_ref_i_i;
relVel_i_i = vel_i_i - vel_ref_i_i;

pos_r_r = rot_r_i*relPos_r_i;
vel_r_i = relVel_i_i - angRate_r_i*[-relPos_r_i(2); relPos_r_i(1)];
vel_r_r = rot_r_i*vel_r_i;


end



