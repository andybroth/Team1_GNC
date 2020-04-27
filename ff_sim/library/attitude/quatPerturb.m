function q = quatPerturb(q,W)
% This function perturbs the quaternion according to the covariance matrix.
% This function assumes that magnitude of each perturbation (otherwise 
% 'Gaussian' perturbation is no valid|
%
% Input:
% - q:  quaternion, scalar last convention
% - W:  covariance matrix for perturbation noise. W(1,1) corresponds to the
%       variance of perturbation in first axis.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if any(W(:))
    delta = sqrtm(W)*randn(3,1);
    q = quatCombine([delta/2; 1],q); % introduce perturbation
    q = quatNorm(q); % normalize
end


end

