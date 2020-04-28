clear all;
close all;
clc;

defineConstants;
defineUnits;

mu_E = 3.986*1E5*KILOMETERS^3;
R_E = EARTH_RADIUS;

% input parameter
rvec0 = [-4743; 4743]*KILOMETERS;
vvec0 = [-5.879; -4.223]*KILOMETERS;
t0 = 0;
dt = 10*MINUTES;


for ii = 1:4
for jj = 1:4

    % nominal
    [rvec,vvec] = kepler_prop(rvec0,vvec0,t0,t0+dt,mu_E);
    stateVec = [rvec;vvec];
    F = kepler_stm(rvec0,vvec0,t0,t,mu_E,R_E);

    N = 100;
    if jj == 1 || jj==2
        pert = linspace(-1000*KILOMETERS,1000*KILOMETERS,N);
    else
        pert = linspace(-1*KILOMETERS,1*KILOMETERS,N);
    end

    stateOut = zeros(4,N);

    for kk = 1:N

        state0_pert = [rvec0;vvec0];
        state0_pert(jj) = state0_pert(jj)+pert(kk);
        [rvec_pert,vvec_pert] = kepler_prop(state0_pert(1:2),state0_pert(3:4),t0,t0+dt,mu_E);
        stateOut(1:2,kk) = rvec_pert;
        stateOut(3:4,kk) = vvec_pert;

    end

    figure()
    plot(pert,stateOut(ii,:)); hold on;
    plot([pert(1) pert(end)],F(ii,jj)*[pert(1) pert(end)]+stateVec(ii));
    title(['test F(',num2str(ii),',',num2str(jj),')']);

end
end




