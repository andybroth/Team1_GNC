% Script setmoon.m
% Solar System Model from Quick 4/11/06
% USE: Set MOON as RTBP model in global.
%      Set paramters for Moon in global mu MOON BODY.
%      Set RTBP conversion units in global RUNIT TUNIT VUNIT AUNIT
% OUT: global mu MOON BODY RUNIT TUNIT VUNIT AUNIT
%      mu = (earth/moon) mass param.

global mu MOON BODY RUNIT TUNIT VUNIT AUNIT

%disp('Set EARTH/MOON RTBP System');
setmoon0;
mu          = MOON.mu;
BODY        = MOON;

[RUNIT,TUNIT,VUNIT,AUNIT]=setunits(BODY);

