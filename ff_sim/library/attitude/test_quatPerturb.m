clear all;
close all
clc;



DEGREES = pi/180;
sigma = 0.1*DEGREES;

q0 = quatRandom();
W = eye(3)*sigma^2;

N = 1000;
deltaTheta_vec = zeros(3,N);
test = zeros(3,N);
for ii = 1:N
    
    test(:,ii) = sqrtm(W)*randn(3,1);
    
    q_pert = quatPerturb(q0,W);
    deltaq = quatCombine(q_pert,quatConj(q0));
    deltaTheta_vec(:,ii) = deltaq(1:3)*2;
    
end

varTheta = var(deltaTheta_vec,0,2);

stdDevTheta = sqrt(varTheta)/DEGREES


varTest  = var(test,0,2);
stdDevVar = sqrt(varTest)/DEGREES


