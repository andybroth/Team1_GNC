function [h,x_out] = visualizeHcw(x0,n,tVec)
% Purpose:
%   This function propagates the initial relative states to some time and
%   plot the relative trajectories based on the HCW equations.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dim = size(x0,1);
N_sc = size(x0,2);
N_sim = length(tVec);
x_out = zeros(dim,N_sim,N_sc);

for ii = 1:N_sim
    if dim == 4
        x_out(:,ii,:) = hcw2d_sol(n,tVec(ii),x0); 
    elseif dim == 6
        x_out(:,ii,:) = hcw_sol(n,tVec(ii),x0); 
    else
        error('wrong dimension');
    end
end

figure()
for jj = 1:N_sc
    if dim == 4
        h = plot(squeeze(x_out(1,:,jj)), ...
                 squeeze(x_out(2,:,jj)));
             
    elseif dim == 6
        h = plot3(squeeze(x_out(1,:,jj)), ...
                  squeeze(x_out(2,:,jj)), ...
                  squeeze(x_out(3,:,jj)));
    end
    
    if jj ==1
        hold on;
    end
end

if dim == 4
xlabel('R (m)');ylabel('T (m)');
elseif dim == 6
xlabel('R (m)');ylabel('T (m)');zlabel('N (m)');
end
axis('equal');


end