function qout = quatMultiplyODot(q1,q2)
% Purpose:
%   Quaternion multiplication. Equivalent to O-dot operator in Ref[1].
%   This function can accomodate multiple entries for second quaternion.
%   Also see "quatMultiplyOTimes".
%
% Input:
% - q1:     first quaternion (4x1)
% - q2:     second quaternion(s) (4xN)
%
% Output:
% - qout:   quaternion product (4xN)
%               qout = q1 (o-dot) q2
%           note that this is mathematically equivalent to
%               qout = q2 (o-times) q1
%
% Reference:
%   [1] Markley, F. Landis, and John L. Crassidis. Fundamentals of
%       spacecraft attitude determination and control. Vol. 33. New York:
%       Springer, 2014.  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s1 = q1(4);
v1 = q1(1:3);

Theta = [s1*eye(3)+skew(v1) v1;
         -v1'               s1];
   
qout = Theta*q2;


end



