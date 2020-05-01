function quatTotal = quatCombineMult(varargin)
% Purpose:
%   Compute combined rotation of two successive rotations. Assume scalar
%   last convention.
%
% Input:
% - quat_C_B:   quaternion rotation from B to C
% - quat_B_A:   quaternion rotation from A to B
%
% Output:
% - quat_C_A:   quaternion rotation from A to C
%
% Author:
%   Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin <2
    error('Number of arguments must be at least two');
end

quatTotal = varargin{1};

for ii = 2:nargin
quatTotal = quatMultiplyOTimes(quatTotal,varargin{ii});
end


end