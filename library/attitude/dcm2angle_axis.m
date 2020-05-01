function [a_vec,theta] = dcm2angle_axis(R)
% Purpose:
%   Computes the angle axis representation (axis of rotation and rotation
%   angle) from a directon cosine matrix. Rotation matrix transforms a
%   vector from N to B, and computed angle axis rotates vector around a_vec
%   by theta (using Rodrigue's formula).
%
% Input:
% - R:  direction cosine matrix that transforms a vector representation in
%       N frame to a vector representation in B frame. (3x3)
%
% Output:
% - a_vec:  unit vector for the axis of rotation (3x1)
% - theta:  angle of rotation (1x1) [rad]
%
% Author: Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

theta = acos((trace(R)-1)/2);
a_cross = (R'-R)/2/sin(theta);

a_vec = zeros(3,1);
a_vec(1) = -a_cross(2,3);
a_vec(2) = a_cross(1,3);
a_vec(3) = -a_cross(1,2);

a_vec = a_vec/norm(a_vec);  % ensure normalization

end