clear all;

DEGREES = pi/180;

R_B_A = euler2dcm321([10 20 30]*DEGREES);
R_C_B = euler2dcm321([45 -10 22]*DEGREES);

R_C_A_1  = R_C_B*R_B_A;

quat_B_A = dcm2quat(R_B_A);
quat_C_B = dcm2quat(R_C_B);

quat_C_A = quatCombine(quat_C_B,quat_B_A);

R_C_A_2 = quat2dcm(quat_C_A);

error = R_C_A_2-R_C_A_1
