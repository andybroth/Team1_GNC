clear all;
close all;
clc;


evec = 0:0.1:0.9;
Evec = linspace(-2*pi,2*pi,1000);

figure()
for ii = 1:length(evec)
    e = evec(ii);
    fvec = kepler_E2f(Evec,e);
    plot(Evec,fvec);
    if ii == 1
        hold on;
    end
end



