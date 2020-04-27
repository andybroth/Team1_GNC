clear all;
close all;

defineConstants;
defineUnits;

mu_E = EARTH_GRAV_CONST;
a = 400*KILOMETERS+EARTH_RADIUS;
n = sqrt(mu_E/a^3);
p0 = [a;
      0];
v0 = [0;a*n];
stateAbsRef = [p0; v0];



posSc_L_L = [10; 10];
x0 = getProArbitPos(n,posSc_L_L,true);
% x0 = getProArbitPos_curvLin(n,stateAbsRef,posSc_L_L,mu_E);
[posAbsSc0, velAbsSc0] = hcwRel2abs2d(x0(1:2),x0(3:4),stateAbsRef(1:2),stateAbsRef(3:4));
stateAbsSc = [posAbsSc0; velAbsSc0];

hsc0 = posAbsSc0(1)*velAbsSc0(2)-posAbsSc0(2)*velAbsSc0(1);
href0 = p0(1)*v0(2)-p0(2)*v0(1);

% temp
N = 600;
tvec = linspace(0,2*HOURS,N);
dt = tvec(2)-tvec(1);
stateAbsSc_out = zeros(4,N);  stateAbsSc_out(:,1) = stateAbsSc;
stateAbsRef_out = zeros(4,N); stateAbsRef_out(:,1) = stateAbsRef;
hRef_out = zeros(1,N);      
hSc_out = zeros(1,N);
stateRel_out = zeros(4,N);

for tt = 1:length(tvec)
    [t1,ysc] = ode45(@(t,x) eomOrbit2d(t,x,mu_E),[0 dt],stateAbsSc);
    [t2,yref] = ode45(@(t,x) eomOrbit2d(t,x,mu_E),[0 dt],stateAbsRef);
    stateAbsSc = ysc(end,:)';
    stateAbsRef= yref(end,:)';
    [pos_L_L,vel_L_L] = hcwAbs2rel2d(stateAbsSc(1:2),stateAbsSc(3:4),stateAbsRef(1:2),stateAbsRef(3:4));
    
    stateAbsSc_out(:,tt) = stateAbsSc;
    stateAbsRef_out(:,tt) = stateAbsRef;
    hSc_out(tt) = stateAbsSc(1)*stateAbsSc(4)-stateAbsSc(2)*stateAbsSc(3);
    hRef_out(tt) = stateAbsRef(1)*stateAbsRef(4)-stateAbsRef(2)*stateAbsRef(3);
    stateRel_out(:,tt) = [pos_L_L; vel_L_L];
end

figure()
plot(tvec,hRef_out)
xlabel('Time');

figure()
plot(stateRel_out(1,:),stateRel_out(2,:));
xlabel('R');ylabel('T');
axis('equal');

error = stateAbsSc_out-stateAbsRef_out;

figure()
for ii = 1:4
subplot(2,2,ii)
plot(tvec/MINUTES,error(ii,:));
end

figure()
for ii = 1:4
subplot(2,2,ii)
plot(tvec/MINUTES,stateAbsRef_out(ii,:)); hold on;
plot(tvec/MINUTES,stateAbsSc_out(ii,:));
end


figure()
plot(tvec/MINUTES,hRef_out); hold on;
plot(tvec/MINUTES,hSc_out); 
