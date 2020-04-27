function R_A_B = rotation2D(theta_B_A)
% Purpose:
%   This funciton computes 2D rotation matrix.
% Input:
% - theta_B_A:  relative angle of frame B with respect to frame A
%
% Output:
% - R_B_A:  rotation matrix that transforms a vector expressed in B to the
%           same vector expressed in A. That is 
%               v_A = R_A_B*v_B
%
% Author:
%   Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R_A_B = [ cos(theta_B_A) sin(theta_B_A);
         -sin(theta_B_A) cos(theta_B_A) ];
    
end