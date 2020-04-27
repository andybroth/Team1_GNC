function [pos_i_i, vel_i_i] = rel2abs(pos_r_r,vel_r_r,rot_i_r,angRate_r_i,pos_ref_i_i,vel_ref_i_i)
% Purpose:
%   This function computes the absolute position and velocity of an object
%   (e.g. a spacecraft) expressed in the relative position and velocity of
%   the rotating and traversing reference frame.
%
% Input:
% - pos_r_r:        relative position expressed in the rotating frame 
% - vel_r_r:        relative velcotiy in rotating frame, expressed in the
%                   rotating frame
% - rot_i_r:        
% - angRate_r_i:
% - pos_ref_i_i:
% - vel_ref_i_i:
%
% Dependency:
% - rot2inert
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% compute the relative position and relative velocity in inertial frame
[relPos_r_i,relVel_i_i] = rot2inert(pos_r_r,vel_r_r,rot_i_r,angRate_r_i);

% compute the absolute position and absolute velocity
pos_i_i = pos_ref_i_i + relPos_r_i;
vel_i_i = vel_ref_i_i + relVel_i_i;


end



