function lpts = lptall(mu)
% function lpts = lptxyz(mu)
%    Calculate location of all libration points lpts(:,Lpt)

mu1=1-mu;

lpts=zeros(5,3);
LPTS = [(mu1-gammaL(mu,1)) (mu1+gammaL(mu,2)) (-mu-gammaL(mu,3))];
lpts(1,1)=LPTS(1);
lpts(2,1)=LPTS(2);
lpts(3,1)=LPTS(3);
lpts(4,1)= .5-mu;
lpts(5,1)= .5-mu;
lpts(4,2)= .5*sqrt(3);
lpts(5,2)=-.5*sqrt(3);
