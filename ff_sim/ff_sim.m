% This scripts implement high fidelity formation flying simulation.

clear all;
close all;
clc;


%% define constants
defineUnits;
defineConstants;

% specify parameters
simParam.dt = 100;
simParam.tEnd = 1.5*HOURS;


%% simulation

tVec = 0:simParam.dt:simParam.tEnd;
nSim = length(tVec);

% initialize reference trajectory orbital parameters
a = 300*KILOMETERS + EARTH_RADIUS;
e = 1E-4;
inc = 3*DEGREES;
omega = 5*DEGREES;
Omega = 0;
nu = 0;

% initialize reference traj pos and vel
[posRef_ECI_ECI,velRef_ECI_ECI] = oe2eci(a,e,inc,omega,Omega,nu,EARTH_GRAV_CONST);
nState  = length(posRef_ECI_ECI) + length(velRef_ECI_ECI);

% relative position
angRateRef_L_I = eci2lvlh_rate(posRef_ECI_ECI,velRef_ECI_ECI);
meanAnom = norm(angRateRef_L_I);
rotRef_L_I = eci2lvlh(posRef_ECI_ECI,velRef_ECI_ECI);

N = 3;
pos_LVLH_LVLH = [0 0 0;
                 0 200 100;
                 0 -200 100]';
vel_LVLH_LVLH = [ 0 0 0;
                  100*meanAnom 0 0;
                 -100*meanAnom 0 0]';
eulerAngle = [ 0 0 0;
               0 0 0;
               0 0 0]';
angRate = [0 0 0;
           0 0 0;
           0 0 0]';

% spacecraft physical parameters
J_B = 100*eye(3);
J_B_inv = inv(J_B);

% compute the absolute position & velocity from SC
for ii = 1:N
    
    [pos_ECI_ECI,vel_ECI_ECI] = rel2abs(pos_LVLH_LVLH(:,ii),vel_LVLH_LVLH(:,ii),rotRef_L_I',angRateRef_L_I,posRef_ECI_ECI,velRef_ECI_ECI);
    [quatRef_L_I] = euler2quat321(eulerAngle(:,ii));
    
    state(ii).stateAbs = [pos_ECI_ECI; vel_ECI_ECI];
    state(ii).stateRel = [pos_LVLH_LVLH(:,ii); vel_LVLH_LVLH(:,ii)];
    state(ii).angRate = angRate(:,ii);
    state(ii).stateAtt  = [quatRef_L_I; angRate(:,ii)];
    
    % relative orbital elements
    if ii == 1
        roe = zeros(6,1);
    else
        roe = relOrbElem(state(1).stateAbs,state(ii).stateAbs,EARTH_GRAV_CONST);
    end
    
end




%% pre-allocate output storage 

for ii= 1:N
    out(ii).stateAbs = zeros(nState,nSim); out(ii).stateAbs(:,1) = state(ii).stateAbs;
    out(ii).stateRel = zeros(nState,nSim); out(ii).stateRel(:,1) = state(ii).stateRel;
end


%% simulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for tt = 1:nSim
    
    tNow = tVec(tt);
    
    % ---- simulate true dynamics -----------------------------------------
    
    for ii = 1:N
        
        % translational dynamics
        [~,y_trans] = ode45(@(t,x) eomOrbit(t,x,EARTH_GRAV_CONST), [tNow tNow+simParam.dt], state(ii).stateAbs);
        [~,y_att] = ode45(@(t,x) eomAttitude(t,x,J_B,J_B_inv), [tNow tNow+simParam.dt], state(ii).stateAtt);
        state(ii).stateAbs = y_trans(end,:)';
        state(ii).stateAtt = y_att(end,:)';
        
    end
        
    
    % ---- analysis -------------------------------------------------------
    
    stateAbsRef = state(1).stateAbs;
    rotRef_L_I = eci2lvlh(stateAbsRef(1:3),stateAbsRef(4:6));
    angRateRef_L_I  = eci2lvlh_rate(stateAbsRef(1:3),stateAbsRef(4:6));
    quatRef_L_I = dcm2quat(rotRef_L_I);
    for ii = 1:N
        
        [pos_r_r,vel_r_r] = abs2rel(state(ii).stateAbs(1:3), state(ii).stateAbs(4:6),rotRef_L_I,angRateRef_L_I,stateAbsRef(1:3),stateAbsRef(4:6));
        state(ii).stateRel = [pos_r_r; vel_r_r];
        out(ii).stateAbs(:,tt) = state(ii).stateAbs;
        out(ii).stateRel(:,tt) = [pos_r_r; vel_r_r];
        
    end
    
end


%% plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Name','Absolute Position')
drawSphere(EARTH_RADIUS); hold on;
plot3(out(1).stateAbs(1,:),out(1).stateAbs(2,:),out(1).stateAbs(3,:));
axis('equal'); 
xlabel('x');
ylabel('y');
zlabel('z');

figure('Name','Reltative Trajectory')
for ii = 1:N
    plot3(out(ii).stateRel(1,:),out(ii).stateRel(2,:),out(ii).stateRel(3,:),'x');
    hold on;
end
axis('equal'); 
xlabel('R');
ylabel('T');
zlabel('N');

