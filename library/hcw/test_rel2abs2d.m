clear all;
close all;
clc;

defineUnits;
defineConstants;

a = 600*KILOMETERS+EARTH_RADIUS;
e = 0.0;
[posRef_I_I,velRef_I_I] = oe2eci2d(a,e,0,EARTH_GRAV_CONST);
[posSc_I_I,velSc_I_I] = oe2eci2d(a,e,100/a,EARTH_GRAV_CONST);
R_L_I = eci2lvlh2d(posRef_I_I,velRef_I_I);
angRate_r_i = getAngRate2d(posRef_I_I,velRef_I_I);

[posSc_L_L,velSc_L_L] = hcwAbs2rel2d(posSc_I_I,velSc_I_I,R_L_I,angRate_r_i,posRef_I_I,velRef_I_I);
[posSc_I_I_2,velSc_I_I2] = hcwRel2abs2d(posSc_L_L,velSc_L_L,R_L_I',angRate_r_i,posRef_I_I,velRef_I_I);


[posSc_I_I, posSc_I_I_2]
[velSc_I_I, velSc_I_I2]
