clear all;
close all;
clc;


% ensure error is small
N_test = 1000;
err_vec = zeros(N_test,1);
for ii = 1:N_test
    
v = randn(3,1);
M1 = expSkew(v);
M2 = expm(skew(v));
err_vec(ii) = norm(M2-M1,'fro');

end

figure
semilogy(err_vec);

% compare time
tic 
M1 = expSkew(v);
toc
tic 
M2 = expm(skew(v));
toc


