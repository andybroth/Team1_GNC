function qstar = quatConj(q)
% Purpose:
%   Return conjugate of quaternion. This assumes that input quaternion has
%   unit length (otherwise, one must divide by norm of quaternion).
%
% Input:
% - q:      quaternion(s) (4xN)
%
% Output:
% - qstar:  conjugate of given quaternion(s) (4xN)
%
% Reference:
%   [1] Markley, F. Landis, and John L. Crassidis. Fundamentals of
%       spacecraft attitude determination and control. Vol. 33. New York:
%       Springer, 2014.  
%w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

qstar = [-q(1:3,:);
          q(4,:)];

end