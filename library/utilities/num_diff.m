function F = num_diff(fcn,x0,epsilon)
% This function evaluates numerical differentiation for y = fcn(x) and
% returns Jacobian of F.
%
% Input:
% - fcn:      function handle of form y = fcn(x)
% - x0:       reference at which numerical differentiation is evaluated
% - epsilon:  step size for numerical differentiation
%
% Output:
% - F:        numerical Jacobian
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dimIn = length(x0);
y0 = fcn(x0);
dimOut = length(y0);

% pre-allocate space for jacobian
F = zeros(dimOut,dimIn);

for jj = 1:dimIn
    x_pert = x0;
    x_pert(jj) = x_pert(jj)+epsilon;
    y_pert = fcn(x_pert);
    F(:,jj) = (y_pert-y0)/epsilon;
end



end