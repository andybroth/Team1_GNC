function [pos_r_r,vel_r_r] = inert2rot(pos_r_i,vel_i_i,rot_r_i,angRate_r_i)
% Purpose:
%   Compute the position and velocity in inertial frame (i) from relative
%   position and velocity in rotating frame (r).
%
% Input:
% - pos_r_i:        relative position of object with respect to the origin
%                   of rotating frame, expressed in the inertial frame
% - vel_i_i:        relative velocity of object with respect to the
%                   inertial frame, expressed in the inertial frame
% - rot_i_r:        rotation from inertial frame to rotating frame
% - angRage_r_i :   angular rate of the rotating frame with respect to
%                   inertial frame, experssed in inertial frame
% Output:
% - pos_r_r:        relative position of object with respect to the origin 
%                   of rotating frame, experessed in the rotating frame
% - vel_I_I:        relative velocity of object with respect to the
%                   rotating frame, experessed in the rotating frame
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


pos_r_r = rot_r_i*pos_r_i;
vel_r_i = vel_i_i - cross(angRate_r_i,pos_r_i);
vel_r_r = rot_r_i*vel_r_i;

end

