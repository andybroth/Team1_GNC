clear all;
close all;
clc;

% WARNING: NOTE THAT THE DEFINITION OF SYNC FUNCTION IN SIGNAL TOOLBOX IS 
% DIFFERENT FROM TYPICAL SINC FUNCTION

for ii = 1:2
    
    if ii == 1 
        x = [-5:0.1:5];
    elseif ii == 2
        x = [-5e-7:1e-8:5e-7];
    end

    figure()
    subplot(2,1,1);
    plot(x,sinc(x/pi)); hold on; grid on;
    plot(x,sinc_custom(x)); 
    xlabel('x');ylabel('y');
    subplot(2,1,2);
    plot(x,sinc(x/pi)-sinc_custom(x)); hold on; grid on;
    xlabel('x');ylabel('error');

end