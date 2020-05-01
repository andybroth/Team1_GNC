clear all;
close all;
clc;


n = 0.0012;


CASES = 3;  % 1: along track formation
            % 2: 


switch CASES
    case 1
       tVec = [0:1.57*3600/5];
        A0 = 0;
        B0 = 0;
        yoff_vec = [-10 0 10];
        alpha= 0;
        beta = 0;
        N = length(yoff_vec);
        x0 = zeros(6,N);
        for ii = 1:N
            yoff = yoff_vec(ii);
            x0(:,ii) = getInitCondHcwProAlphaBeta(n,A0,B0,alpha,beta,yoff);
        end
        
    case 2
        tVec = [0:1.57*3600/5];
        A0 = 5;
        B0 = 10;
        yoff = 0;

        alpha_vec = [0 1/3 2/3]*2*pi;
        N = length(alpha_vec);
        x0 = zeros(6,N);
        
        for ii = 1:N
            alpha = alpha_vec(ii);
            beta = alpha;
            x0(:,ii) = getInitCondHcwProAlphaBeta(n,A0,B0,alpha,beta,yoff);
        end
        
    case 3
        tVec = [0:1.57*3600];
        A0 = 5;
        B0 = 10;
        yoff = 0;

        alpha_vec = [0 1/3 2/3]*2*pi;
        N = length(alpha_vec);
        x0 = zeros(6,N);
        
        for ii = 1:N
            alpha = alpha_vec(ii);
            beta = 0;
            x0(:,ii) = getInitCondHcwProAlphaBeta(n,A0,B0,alpha,beta,yoff);
        end        
end


[h,x_out] = visualizeHcw(x0,n,tVec);

if CASES == 2
    nSim = size(x_out,2);
    colorMat = get(gca,'colororder');
    xrange = xlim;
    for ii = 1:N
        
        % extract T and N parts of trajectory
        projected = [ones(1,nSim)*xrange(2);
                     squeeze(x_out(2:3,:,ii))];
        plot3(projected(1,:),projected(2,:),projected(3,:),'--','color',colorMat(ii,:));
    end
end

