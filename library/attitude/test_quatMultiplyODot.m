clear all;
close all;
clc;



N = 5;


q_1 = quatRandom();
q_2 = zeros(4,N);
q_3 = zeros(4,N);
for ii = 1:N
    q_2(:,ii) = quatRandom();
    q_3_itr(:,ii)= quatCombine(q_2(:,ii),q_1);
end

% using 'quatMultiplyODot', one can do batch multiplication of quaternion
% where there left hand side of the 'o-times' operator is an array of
% quaternions. that is
%       q3 = q2 o-times q1
% can be equivalently written as
%       q3 = q1 o-dot q2
%

q_3_batch = quatMultiplyODot(q_1,q_2);
q_3_itr
q_3_batch
error = q_3_itr-q_3_batch