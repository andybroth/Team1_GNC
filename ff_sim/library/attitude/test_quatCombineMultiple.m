clear all; close all; 

DEGREES = pi/180;
q_E_D = euler2quat321(randn(3,1)*3*DEGREES);
q_D_C = euler2quat321(randn(3,1)*3*DEGREES);
q_C_B = euler2quat321(randn(3,1)*3*DEGREES);
q_B_A = euler2quat321(randn(3,1)*3*DEGREES);

% combine all at once
q_E_A1 = quatCombineMult(q_E_D,q_D_C,q_C_B,q_B_A);

q_C_A = quatCombine(q_C_B,q_B_A);
q_D_A = quatCombine(q_D_C,q_C_A);
q_E_A2 = quatCombine(q_E_D,q_D_A);


q_E_A1-q_E_A2