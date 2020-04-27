clear all;
close all;
clc;


n = 0.0011;
tend = 2*2*pi/n;
t = [0:pi/n/100:tend];

[~,Phi_this] = hcw_sol(n,2*pi/n,nan(6,1));
det(Phi_this)
N = length(t);
detvec = zeros(N,1);
for ii = 1:N
[~,Phi] = hcw_sol(n,t(ii),nan(6,1));
detvec(ii) = det(Phi);
end
figure()
plot(t,detvec);