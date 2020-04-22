function [RUNIT,TUNIT,VUNIT,AUNIT]=setunits(BODY)
% funtcion [RUNIT,TUNIT,VUNIT,AUNIT]=setunits(BODY)
% USE: Set conversion units for RTBP of BODY.

RUNIT = BODY.sm;           % Distance [km]        = 1 RTBP Unit
TUNIT = BODY.period/2/pi;  % Time     [sec]       = 1 RTBP Unit
VUNIT = RUNIT/TUNIT;       % Distance [km/sec]    = 1 RTBP Unit
AUNIT = VUNIT/TUNIT;       % Distance [km/sec^2]  = 1 RTBP Unit

