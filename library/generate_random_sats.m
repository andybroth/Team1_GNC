%% Generates a random satellite IC
% Bounds:
%   center - [x y z] location of spacecraft
%   N - number of satellites to generate IC for
%   mind - min distance from SC m
%   maxd - max distance from SC m
%   minv - min velocity at ejection m/s
%   maxv - max velocity at ejection m/s
%   rad_out - switch, 0 = use a random velocity vector
%                     1 = calculate velocities radially outward
function X = generate_random_sats(center, N, mind, maxd, minv, maxv, rad_out)
    % Min/max time to check position
    % based on position and velocity constraints
    v_mag = rand(1,N,'double')*(maxv - minv)+ minv;       % 1xN vector m/s
    X = zeros(N,6) ;
    for i=1:N
        min_t = mind/v_mag(i);
        max_t = maxd./v_mag(i);
        time = rand.*(max_t-min_t)+min_t;   % s

        % Calculate the radius for spherical coords
        r = time*v_mag(i); % 1xN vector of radius in m

        % random xy angle
        theta = randsample(linspace(0,2*pi),1);
        % random z -> xy angle
        phi = randsample(linspace(0,pi),1);

        % Convert to cartesian coords
        Px = center(1)+r*cos(theta)*sin(phi) ;
        Py = center(2)+r*sin(theta)*sin(phi) ;
        Pz = center(3)+r*cos(phi) ;
        
        % Radially out velocity switch
        switch rad_out
            case 1
                % Calculate velocity components(radial from center)
                x2 = Px;
                y2 = Py;
                z2 = Pz;
            otherwise
                % Calculate a random velocity
                x2 = rand -0.5;
                y2 = rand - 0.5;
                z2 = rand - 0.5;
        end
        nm = sqrt((x2^2 + y2^2 + z2^2)/v_mag(i)^2);

        vx = x2/nm;
        vy = y2/nm;
        vz = z2/nm;

        X(i,:) = [Px, Py, Pz, vx, vy, vz];
    end

% dist = Ddist(center,p);
end