function M = expSkew(v)
% Analytically compute matrix exponential of skew symmetric matrix. This is
% equivalent to:
%     M = expm(skew(v))
%
% experiment shows that this function is SLOWER than expm(skew(v)).... 
% so don't use this funciton.
%
% Ref: https://math.stackexchange.com/questions/879351/matrix-exponential-of-a-skew-symmetric-matrix
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


skewV = skew(v);
x = sqrt(v(1)^2+v(2)^2+v(3)^2);
M = eye(3)+sin(x)/x*skewV + (1-cos(x))/x^2*skewV*skewV;

end