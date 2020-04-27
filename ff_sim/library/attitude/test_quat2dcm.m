% 

rng(1);

DEGREES = pi/180;
roll  = 20*DEGREES;
pitch = 0*DEGREES;
yaw   = 0*DEGREES;
euler = [yaw pitch roll]';
R_B_N = euler2dcm321(euler);
q_B_N = dcm2quat(R_B_N);

% test this algorithm below
R2 = quat2dcm(q_B_N);

x_N = randn(3,1);
x_B1 = R_B_N*x_N
x_B2 = quatRotateVec(q_B_N,x_N)

