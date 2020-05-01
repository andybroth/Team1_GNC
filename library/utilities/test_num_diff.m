clear all;
close all;
clc;


wref = randn(3,1);
state0 = zeros(6,1);
F = num_diff(@(x) f(x,wref), state0);

% compute expected F (assume state0 = zeros);
F_analytical = [-skew(wref) eye(3)];

% this should be zero
F_err = F-F_analytical;


% time-derivative of error quaternion and error angular rate
function fout = f(state,wRef)

a = state(1:3);
eta = state(4:6);

fout = 0.5*(sqrt(4-a'*a)*eta-2*cross(wRef,a)-cross(eta,a));

end