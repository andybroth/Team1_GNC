function x0 = getProArbitPos(n,pos_vec,flagCentered)
% Purpose:
%   This function provides the initial relative state that will yield no
%   relative drift.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vel_vec = zeros(size(pos_vec));
vel_vec(2,:) = -2*n*pos_vec(1,:);

if flagCentered
    vel_vec(1,:) = n*pos_vec(2,:)/2;
end
x0 = [pos_vec; vel_vec];


end


