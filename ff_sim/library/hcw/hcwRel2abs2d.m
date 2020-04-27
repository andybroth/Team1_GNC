function [pos_i_i, vel_i_i] = hcwRel2abs2d(pos_r_r,vel_r_r,pos_ref_i_i,vel_ref_i_i)
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

% rotaiton matrix and angular rate
rot_r_i = eci2lvlh2d(pos_ref_i_i,vel_ref_i_i);
angRate_r_i = getAngRate2d(pos_ref_i_i,vel_ref_i_i);
    
rot_i_r = rot_r_i';
relPos_r_i = rot_i_r*pos_r_r;
relVel_r_i = rot_i_r*vel_r_r;

% vel_i_i = vel_r_i + cross(angRate,pos_r_i)
relVel_i_i = relVel_r_i + angRate_r_i*[-relPos_r_i(2),relPos_r_i(1)]';

% compute the absolute position and absolute velocity
pos_i_i = pos_ref_i_i + relPos_r_i;
vel_i_i = vel_ref_i_i + relVel_i_i;


end



