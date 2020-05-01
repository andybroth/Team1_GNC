function v = perturbVec(v,covar)
% Compute a perturbed vector, given a covariance. Assume the noise is
% linear and Gaussian. 
% 
% Input: 
% - v:      vector of N x 1
% - cov:    covariance of size N x N
% Output:
% - v_pert: perturbed vector
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if any(covar(:))
    v = v + sqrtm(covar)*randn(size(v));
end

end