function [n] = quatNorm(q)
% Normalize Quaternion
n = q / sqrt(q'*q);
end

