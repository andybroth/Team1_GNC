% Script setmoon0.m
% Solar System Model from Quick 4/11/06
% USE: Set paramters for Moon. Return in obj MOON in global.
% OUT: global mu MOON
%      mu = (earth moon) mass param.
global mu BODY MOON

disp('Set MOON System');
SUN.gm      = 132712440017.986999511718750000;
EARTH.gm    = 398600.432896939164493233;
MOON.name   = 'MOON';
MOON.gm     = 4902.800582;
MOON.mu     = MOON.gm/(EARTH.gm+MOON.gm);
MOON.sm     = 386274.56245094; % km, from quick
MOON.period = 2360591.510; % sec
MOON.radius = 1737.400;
MOON.j2     = 0.;
MOON.j3     = 0.;
MOON.flat   = 0;
MOON.rotD   = .0; % Deg/Sec
MOON.rot    = .0;       % Rev/Day
MOON.PM     = .0;       % Rad
MOON.PMD    = .0;     % Deg

% These set in setmoon.m
% mu          = MOON.mu;
% BODY        = MOON;

% Aug 31, 2012
%>jd=date(20140101.0)
%>satelm(jd,1,3)
% SATELM   =    386274.56245094      76.23356661697E-03   5.0512105271461
%               215.33707789955      73.356723103951      347.13536881214

