function theta = wrapAngle(theta,opt)

switch opt
    case 'piToPi'
        theta = mod(theta+pi,2*pi)-pi;
    case '0To2Pi'
        theta = mod(theta,2*pi);
    otherwise
        error('choose correct option!');
end

end