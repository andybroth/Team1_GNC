clear all;
close all;
clc;


DEGREES = pi/180;
yaw = 0.1*DEGREES;
% pitch = 0.2*DEGREES;
% roll = 0.3*DEGREES;
% yaw = 0;
pitch = 0;
roll = 0;
euler = [yaw pitch roll]';

q_B_I = euler2quat321(euler);
R_B_I = quat2dcm(q);
alpha_small_angle = 2*q(1:3)/DEGREES