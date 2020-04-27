function q = dcm2quat(R)
% Purpose:
%   Computes quaterinion from rotation cosine matrix using Sheppard's
%   algorithm. 
% 
% Input:
% - R:      direction consine matrix that transforms a vector expressed in
%           N to the same vector expressed in B frame. That is
%                   v_B = R*v_N
% 
% Output:
% - q:      quaternion that transforms a vector from N to B frame. Scalar
%           last.
%
% Author:   Kai Matsuka
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trR = trace(R);

b0_square = (1+trR)/4;
b1_square = (1+2*R(1,1)-trR)/4;
b2_square = (1+2*R(2,2)-trR)/4;
b3_square = (1+2*R(3,3)-trR)/4;

[~,ind] = max([b0_square b1_square b2_square b3_square]);

switch ind
    case 1
        b0 = sqrt(b0_square);
        b1 = (R(2,3)-R(3,2))/4/b0;
        b2 = (R(3,1)-R(1,3))/4/b0;
        b3 = (R(1,2)-R(2,1))/4/b0;
    case 2
        b1 = sqrt(b1_square);
        b0 = (R(2,3)-R(3,2))/4/b1;
        b2 = (R(1,2)+R(2,1))/4/b1;
        b3 = (R(1,3)+R(3,1))/3/b1;
    case 3
        b2 = sqrt(b2_square);
        b0 = (R(3,1)-R(1,3))/4/b2;
        b1 = (R(1,2)+R(2,1))/4/b2;
        b3 = (R(2,3)+R(3,2))/4/b2;
    case 4
        b3 = sqrt(b3_square);
        b0 = (R(1,2)-R(2,1))/4/b3;
        b1 = (R(1,3)+R(3,1))/3/b3;
        b2 = (R(2,3)+R(3,2))/4/b3;
end


q = [b1; b2; b3; b0]; % use scalar-last convention
q = q/sqrt(q'*q);     % enforce normalization
if b0 < 0
    q = -q;
end

end