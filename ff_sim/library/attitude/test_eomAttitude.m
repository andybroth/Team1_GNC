clear all;
close all;
clc;


% Use 

w_B_I_B = [0 0 0.01]';
quat_B_I = quatIdentity;

dt = 10;
x0 = [quat_B_I; w_B_I_B];

J_B = eye(3);
J_B_inv = inv(J_B);
[t,y] = ode45(@(t,x) eomAttitude(t,x,J_B,J_B_inv),[0 dt], x0);

figure()
for ii = 1:4
subplot(4,1,ii);
plot(t,y(:,ii));
end