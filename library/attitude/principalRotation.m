function R = principalRotation(axis,theta)
% inputs:
% - axis:    1,2,3 (-)
% - theta:   rotation agnle (rad)
%
% outputs:
% - R:       rotation matrix (3x3)
%
% author: Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


c = cos(theta);
s = sin(theta);

switch axis
    case 1
        R = [ 1  0  0;
              0  c  s;
              0 -s  c];
    case 2
        R = [ c  0 -s;
              0  1  0;
              s  0  c];
    case 3
        R = [ c  s  0;
             -s  c  0;
              0  0  1];
    otherwise 
        error('Select axis value from 1, 2, or 3.');
end

end