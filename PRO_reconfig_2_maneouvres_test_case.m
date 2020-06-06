%% AE 105c PRO RECONFIGURATION SCP
% Code Written by: Garima Aggarwal
% Date: May 18th 2020
% Use sequential convex optimization to solve numerically an optimal impulsive 
% trajectory(2D) starting from a given PRO to final PRO while
% minimizing delta_v for firing
 
clear all
clc
close all

codeblocks_out = [  0.0645326 , 0.592586 , 0.465235 , 0.0126865 , 3844.73 , 95.044];
%     0.00289271 , 0.125288 , 0.0499885 , 0.0555751 , 4523.57 , 234.543]; % SAT3 
%     0.308459 , 0.638705 , 0.0651937 , 0.0543673 , 5157.1 , 138.84]; % SAT 1
%     0.0586793 , 0.192269 , 2.71862e-005 , 0.0484506 , 5101.18 , 412.206]; 
%     0.010507 , 0.0626436 , 0.0906625 , 0.0325416 , 202.016 , 367.12];
%     0.0298814 , 0.101176 , 0.0740342 , 0.0270203 , 2829.98 , 285.261];
%     0.220603 , 0.744269 , 0.121117 , 0.0556852 , 2444.42 , 195.513];
CASE_TYPE = 1;
% Known constants
mhu= 398600; %Gravitational constant of Earth in km^3/s^2
Re = 6378; % Radius of Earth  in km

% chief s/c value
a_chief = Re + 350; %semi-major axis of the orbit of the chief - km
period = 2*pi*sqrt(a_chief^3/mhu); %period of the chief orbit in seconds
n = 2*pi/period; %Mean motion in radians/second
mean_motion = n;

state_PRO1_in(1,:) = [  7.0125   98.4772   14.0254    0.0557   -0.0160   -0.0023]; % SAT 2
% 22.2639   60.7570   39.8452    0.0325   -0.0509    0.0582]; % SAT 3
%     -41.5742 ,  48.7663 ,  18.1328  ,  0.0270 ,   0.0951 ,  -0.0118]; %SAT 1 


state_PRO1_in(1,5) = -2*mean_motion*state_PRO1_in(1);

switch CASE_TYPE
    case 0
        state_PRO1_in(1,6) = state_PRO1_in(4)*state_PRO1_in(3)/state_PRO1_in(1);
    case 1
        state_PRO1_in(1,6) = -mean_motion^2*state_PRO1_in(1)*state_PRO1_in(3)/state_PRO1_in(4);
end
% relative orbit sizes in the LVLH frame given the initial PRO conditions
rhox1 = sqrt(state_PRO1_in(1)^2*mean_motion^2 + state_PRO1_in(4)^2)/mean_motion;
rhoy1 = state_PRO1_in(2) - 2*state_PRO1_in(4)/mean_motion;
% rhoz1 = sqrt(state_PRO1_in(3)^2*mean_motion_sq + state_PRO1_in(6)^2)/mean_motion;
% alphax1 = atan2(mean_motion*state_PRO1_in(1),state_PRO1_in(4));
% alphaz1 = atan2(mean_motion*state_PRO1_in(3),state_PRO1_in(6));

%% PRO1
time = 0:10:period; 
% Time = 0 is the time of ejection of the cubesat from the spacecraft
for i=1:1:length(time)
    states_PRO1(i,1:6) = exppA_state(n,time(i))*state_PRO1_in'; %HCW equations-closed form solution
end

%% INtermediate PRO
time_inter = 0:10:codeblocks_out(6);
firing1_before = exppA_state(n,codeblocks_out(5))*state_PRO1_in';
% exppA_state(n,codeblocks_out(5))
firing1_after = [firing1_before(1:3); codeblocks_out(1); codeblocks_out(2); codeblocks_out(3);];
for i=1:1:length(time_inter)
    states_inter(i,1:6) = exppA_state(n,time_inter(i))*firing1_after; %HCW equations-closed form solution
end
deltav1 = vecnorm(firing1_before(4:6) - firing1_after(4:6));

%% PRO2
firing2_before = exppA_state(n,codeblocks_out(6))*firing1_after;
firing2_after = [firing2_before(1:3); codeblocks_out(4)];
firing2_after(5) = -2*n*firing2_after(1);


switch CASE_TYPE
    case 0  
        firing2_after(6) = -n^2*firing2_after(1)*firing2_after(3)/firing2_after(4);
    case 1
        firing2_after(6) = firing2_after(4)*firing2_after(3)/firing2_after(1);
end

deltav2 = vecnorm(firing2_before(4:6) - firing2_after(4:6));
for i=1:1:length(time)
    states_PRO2(i,1:6) = exppA_state(n,time(i))*firing2_after; %HCW equations-closed form solution
end

rhox2 = sqrt(firing2_after(1)^2*mean_motion^2 + firing2_after(4)^2)/mean_motion;
rhoy2 = firing2_after(2) - 2*firing2_after(4)/mean_motion;

deltaV = deltav1 + deltav2;

%%
% plot(dist)
% %%
figure (1)
title('Relative coordinate');
hold on
xlabel('x');
ylabel('y');
zlabel('z');
grid on;
plot3(states_inter(:,1), states_inter(:,2), states_inter(:,3), 'g','DisplayName', 'Inter PRO');
plot3(states_PRO1(:,1), states_PRO1(:,2), states_PRO1(:,3), 'r','DisplayName', 'PRO1');
plot3(states_PRO2(:,1), states_PRO2(:,2), states_PRO2(:,3), 'b','DisplayName', 'PRO2');
hold on
plot3(state_PRO1_in(1), state_PRO1_in(2), state_PRO1_in(3), 'r*', 'DisplayName','PRO1 initial');
plot3(firing1_before(1), firing1_before(2), firing1_before(3), 'g*', 'DisplayName','Fire 1');
plot3(firing2_before(1), firing2_before(2), firing2_before(3), 'b*', 'DisplayName','Fire 2');
grid on
plot3(0,0,0,'k*', 'DisplayName','Chief');
axis equal
legend();

%%
figure(2)
grid on 
hold on
subplot(2,2,1)
hold on
plot(states_inter(:,1), states_inter(:,2), 'g','DisplayName', 'Inter PRO');
plot(states_PRO1(:,1), states_PRO1(:,2), 'r','DisplayName', 'PRO1');
plot(states_PRO2(:,1), states_PRO2(:,2), 'b','DisplayName', 'PRO2');
hold on
plot(state_PRO1_in(1), state_PRO1_in(2), 'r*', 'DisplayName','PRO1 initial');
plot(firing1_before(1), firing1_before(2), 'g*', 'DisplayName','Fire 1');
plot(firing2_before(1), firing2_before(2), 'b*', 'DisplayName','Fire 2');
grid on 
hold on
plot(0,0,'*');
title('X-Y plane')
xlabel('X');
ylabel('Y');
axis equal

subplot(2,2,2)
hold on
plot(states_inter(:,2), states_inter(:,3), 'g','DisplayName', 'Inter PRO');
plot(states_PRO1(:,2), states_PRO1(:,3), 'r','DisplayName', 'PRO1');
plot(states_PRO2(:,2), states_PRO2(:,3), 'b','DisplayName', 'PRO2');
hold on
plot(state_PRO1_in(2), state_PRO1_in(3), 'r*', 'DisplayName','PRO1 initial');
plot(firing1_before(2), firing1_before(3), 'g*', 'DisplayName','Fire 1');
plot(firing2_before(2), firing2_before(3), 'b*', 'DisplayName','Fire 2');
grid on 
hold on
plot(0,0,'*');
title('Y-Z plane')
xlabel('Y');
ylabel('Z');
axis equal

subplot(2,2,3)
hold on
plot(states_inter(:,1), states_inter(:,3), 'g','DisplayName', 'Inter PRO');
plot(states_PRO1(:,1), states_PRO1(:,3), 'r','DisplayName', 'PRO1');
plot(states_PRO2(:,1), states_PRO2(:,3), 'b','DisplayName', 'PRO2');
hold on
plot(state_PRO1_in(1), state_PRO1_in(3), 'r*', 'DisplayName','PRO1 initial');
plot(firing1_before(1), firing1_before(3), 'g*', 'DisplayName','Fire 1');
plot(firing2_before(1), firing2_before(3), 'b*', 'DisplayName','Fire 2');
grid on 
hold on
plot(0,0,'*');
title('X-Z plane')
xlabel('X');
ylabel('Z');
axis equal

subplot(2,2,4)
hold on
plot3(states_inter(:,1), states_inter(:,2), states_inter(:,3), 'g','DisplayName', 'Inter PRO');
plot3(states_PRO1(:,1), states_PRO1(:,2), states_PRO1(:,3), 'r','DisplayName', 'PRO1');
plot3(states_PRO2(:,1), states_PRO2(:,2), states_PRO2(:,3), 'b','DisplayName', 'PRO2');
hold on
plot3(state_PRO1_in(1), state_PRO1_in(2), state_PRO1_in(3), 'r*', 'DisplayName','PRO1 initial');
plot3(firing1_before(1), firing1_before(2), firing1_before(3), 'g*', 'DisplayName','Fire 1');
plot3(firing2_before(1), firing2_before(2), firing2_before(3), 'b*', 'DisplayName','Fire 2');
grid on 
hold on
plot3(0,0,0,'*');
title('X-Y-Z plane')
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal
make_animation(1);

%% Compute the state of the deputy in LHLV frame
% INPUT: mean motion of the chief (n), Time from the reference(t-t0)
% OUTPUT: State transition matrix
% ref: Chapter 5(Formation Flying) Eqn 5.16
function expA_state = exppA_state(n, time)
snt = sin(n*time);
cnt = cos(n*time);
expA_state = [  4-3*cnt, 0, 0, snt/n, 2/n-2*cnt/n, 0;
                -6*n*time+6*snt, 1, 0, -2/n+2*cnt/n, 4*snt/n-3*time, 0;
                0, 0, cnt, 0, 0, snt/n;
                3*n*snt, 0, 0, cnt, 2*snt, 0;
                -6*n+6*n*cnt, 0, 0, -2*snt, -3+4*cnt, 0;
                0, 0, -n*snt, 0, 0, cnt];
end



function [] = make_animation(num)
az = 0;
el = 90;
view([az,el])

degStep = 2.5;
detlaT = 0.3;
fCount = 71;
f = getframe(gcf);
[im,map] = rgb2ind(f.cdata,256,'nodither');
im(1,1,1,fCount) = 0;
k = 1;
% spin 45°
for i = 0:-degStep:-45
  az = i;
  ([az,el]);
  f = getframe(gcf);
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
% tilt down
for i = 90:-degStep:15
  el = i;
  view([az,el])
  f = getframe(gcf);
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
% spin left
for i = az:-degStep:-90
  az = i;
  view([az,el])
  f = getframe(gcf);
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
% spin right
for i = az:degStep:0
  az = i;
  view([az,el])
  f = getframe(gcf);
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
% tilt up to original
for i = el:degStep:90
  el = i;
  view([az,el])
  f = getframe(gcf);
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
imwrite(im,map,"plot.gif",'DelayTime',detlaT,'LoopCount',inf)
end

