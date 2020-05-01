function q = quatIdentity(varargin)
%  This function returns identity quaternion with scalar last convention.
%  
%  q = quatIdentity()  returns one identity quaternion of form (4x1) vector
%  q = quatIdentity(n) returns n identiy quaternion of form (4xn) vector
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 0
    n = 1;
elseif nargin == 1
    n = varargin{1};
else
    error('accepts only one input with real integer values');
end

q = [zeros(3,n); ones(1,n)];

end