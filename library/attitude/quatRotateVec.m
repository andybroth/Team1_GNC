function v_b =  quatRotateVec(q_b_a,v_a)
% Purpose:
%   Rotates vector(s) v_a by quaternion q_b_a. This function can accomodate
%   multiple vectors in v_a, but accepts only one quaternion.
%
% Input:
% - q_b_a:  quaternion that rotates a vector expressed in frame A to the
%           same vector expressed in frame B (4x1)
% - v_a:    vector expressed in frame A (3xN)
% 
% Output:
% - v_b:    vector expressed in frame B (3xN)
% 
% Author:   Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = size(v_a,2);

temp  = quatMultiplyODot(quatConj(q_b_a),[v_a; zeros(1,N)]);
temp2 = quatMultiplyOTimes(q_b_a,temp);

v_b = temp2(1:3,:);

end