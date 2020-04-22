% Solar System Model from Quick 4/11/06
% USE: Set paramters for Earth. Return in EARTH in global.
%      To set Sun-Earth/Moon Model for RTBP, call setearth.m
% OUT: global AU EARTH
%      AU = EARTH.sm
% VER: 9/1/2012

global mu AU BODY EARTH MODEL

%disp('Set constants for object EARTH ind AU n global');
%disp('    To set Sun-Earth/Moon Model for RTBP, call setearth.m');
% SUN.gm       = 132712440017.986999511718750000;
SUN.gm       = 132712440017.986999511720000000;    % Aug 2013
EARTH.name   = 'EARTH';
EARTH.gm     = 398600.432896939164493230;          % [km^3/s^2]
EARTH.gmbary = 403503.233479;                      % Earth-Moon Barycenter Gravity
EARTH.mu     = EARTH.gm/(SUN.gm+EARTH.gm);         % Earth's 3 Body Mass Parameter
EARTH.mubary = EARTH.gmbary/(EARTH.gmbary+SUN.gm); % Earth-Moon 3 Body Mass Parameter
EARTH.sm     = 149597927.000; % km                 % Earth Semimajor Axis
EARTH.period = 31556924.867; % sec                 % Earth's Rotation Solar Days
EARTH.radius = 6378.136d0;                         % KM, Equatorial Radius
EARTH.j2     = 0.001082627;           % Equatorial Bulge Spherical Harmonics
EARTH.j3     = -0.2536414d-5;         % More Spherical Harmonics
EARTH.flat   = 298.257;               % 1/f, where f=Earth Flattening Factor
EARTH.rotD   = 4.178074346064814d-03; % Deg/Sec, with respect to Sun
           % = 360.9856235000000      % [deg/day], with respect to Sun
EARTH.rot    = 1.0027378430556;       % Rev/Day, with respect to Sun
EARTH.PM     = 3.3186912127897;       % Rad J2000, Prime Maridian at Greenwich
EARTH.PMD    = 190.1470000000000;     % Deg J2000, Prime Maridian at Greenwich
EARTH.nm     = 2*pi/EARTH.period;     % [radians/sec] Earth's mean motion

% AU           = EARTH.sm;            % Astronomicald Unit, Mean Sun-Earth Semimajor Axis
AU           = 149597870.691000015;   %[km]

MODEL = 'EarthModel';

% Use setearth.m to get thee constants in the global.
%mu           = EARTH.mubary;
%BODY         = EARTH;
