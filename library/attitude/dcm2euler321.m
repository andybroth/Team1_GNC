function euler = dcm2euler321(R)
% Purpose:
%   This function computes Euler angles from DCM, assuming 3-2-1 Euler
%   sequence.
%
% Input:
% - R:      DCM from frame N to B
% 
% Output:
% - euler:  euler angles that rotates a vector in frame N to B in 3-2-1
%           sequence. [rad] (3x1)
%                   euler = [alpha beta gamma]'
%           and
%                   R = Rx(gamma)*Ry(beta)*Rz(alpha)
%           
%
% Author:   Kai Matsuka
% Date:     01/31/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% To avoid complex number numerical issue, ensure argument to acos function
% is -1<= and <=1
alphaArg = R(1,1)/sqrt(1-R(1,3)^2);
if abs(alphaArg)>1; alphaArg=sign(alphaArg); end

if R(1,2) >= 0 
    alpha = acos(alphaArg);
else
    alpha = -acos(alphaArg);
end

betaArg = sqrt(1-R(1,3)^2);
if abs(betaArg)>1; betaArg=sign(betaArg); end

if R(1,3) <= 0 
    beta = acos(betaArg);
else
    beta = -acos(betaArg);
end

gammaArg = R(3,3)/sqrt(1-R(1,3)^2);
if abs(gammaArg)>1; gammaArg=sign(gammaArg); end

if R(2,3) >= 0 
    gamma = acos(gammaArg);
else
    gamma = -acos(gammaArg);
end

euler = [alpha; beta; gamma]; %[rad]

end

 