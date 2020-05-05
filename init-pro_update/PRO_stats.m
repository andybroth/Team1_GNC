function [] = PRO_stats(deltavs, statePRO, N, period, miss, miss_v, total_v)
min_d = zeros(N,1);
max_d = zeros(N,1);
dist = zeros(N,556);
for i = 1:N
    for j = 1:length(statePRO(i,:,1))
        dist(i,j) = norm(squeeze(statePRO(i,j,1:3)));
    end
    min_d(i) = min(dist(i,:));
    max_d(i) = max(dist(i,:));
end
% How often we get a solution
disp("No PROs found: "+miss);
disp("Converges "+100.0*N/(miss+N)+"% of the time");

% Avg min and max distances
disp("Average min dist (m): "+mean(min_d));
disp("Average max dist (m): "+mean(max_d));

% Avg Delta v
disp("Average delta v (m/s): "+mean(deltavs));
disp(" ")

% Time under a specific distance
[t75 ,sd75 ] = dist_below(75, dist,N);
[t100,sd100] = dist_below(100,dist,N);
[t125,sd125] = dist_below(125,dist,N);
[t150,sd150] = dist_below(150,dist,N);

disp("Total Period (min): " + period/60);
disp("Avg time <75m   (min): " + t75 + " +- "+ sd75);
disp("Avg time <100m  (min): " + t100+ " +- "+ sd100);
disp("Avg time <125m  (min): " + t125+ " +- "+ sd125);
disp("Avg time <150m  (min): " + t150+ " +- "+ sd150);
disp(" ")

% Percentage that get under each distance
disp("PROs that get <75m:  "+nnz(min_d < 75)*100/N+"%");
disp("PROs that get <100m: "+nnz(min_d < 100)*100/N+"%");
disp("PROs that get <125m: "+nnz(min_d < 125)*100/N+"%");
disp("PROs that get <150m: "+nnz(min_d < 150)*100/N+"%");
disp(" ")

% Looking at velocities that couldn't make a PRO
disp("Average miss vx (m/s): "+mean(miss_v(:,1))+" +- "+std(miss_v(:,1)));
disp("Average PRO  vx (m/s): "+mean(total_v(:,1))+" +- "+std(total_v(:,1)));
disp("Average miss vy (m/s): "+mean(miss_v(:,2))+" +- "+std(miss_v(:,2)));
disp("Average PRO  vy (m/s): "+mean(total_v(:,2))+" +- "+std(total_v(:,2)));
disp("Average miss vz (m/s): "+mean(miss_v(:,3))+" +- "+std(miss_v(:,3)));
disp("Average PRO  vz (m/s): "+mean(total_v(:,3))+" +- "+std(total_v(:,3)));
disp(" ")

% Looking at velocity magnitudes that couldn't make a PRO
disp("Average abs miss vx (m/s): "+mean(abs(miss_v(:,1)))+" +- "+std(miss_v(:,1)));
disp("Average abs PRO  vx (m/s): "+mean(abs(total_v(:,1)))+" +- "+std(total_v(:,1)));
disp("Average abs miss vy (m/s): "+mean(abs(miss_v(:,2)))+" +- "+std(miss_v(:,2)));
disp("Average abs PRO  vy (m/s): "+mean(abs(total_v(:,2)))+" +- "+std(total_v(:,2)));
disp("Average abs miss vz (m/s): "+mean(abs(miss_v(:,3)))+" +- "+std(miss_v(:,3)));
disp("Average abs PRO  vz (m/s): "+mean(abs(total_v(:,3)))+" +- "+std(total_v(:,3)));
disp(" ")

% Looking at total initial speed
disp("Average miss speed (m/s): "+mean(vecnorm(miss_v'))+" +- "+std(vecnorm(miss_v')));
disp("Average PRO  speed (m/s): "+mean(vecnorm(total_v'))+" +- "+std(vecnorm(total_v')));
disp(" ")

% Going to see how often collisions happen, coll is collision distance
% coll = 10;
% trials = 2*N;
% hits = get_hits(statePRO, N, trials, coll);

% disp("Collisions within "+coll+"m: "+100.0*hits/trials+"%");
end

function [hits] = get_hits(statePRO, N, trials, coll)
hits = 0;
a = length(statePRO(1,:,1));
for i = 1:trials
    r = randi([1, N],1,2);
    for k = 1:a
        if norm(squeeze(statePRO(r(1),k,1:3)-statePRO(r(2),k,1:3))) < coll
            hits = hits + 1;
            break
        end
    end
end
end

function [t, sd] = dist_below(r, dist, N)
time = zeros(N,1);
for i = 1:N
    time(i) = nnz(r > dist(i,:))*10;
    if time(i) > 0
        time(i) = time(i) - 10;
    end
    time(i) = time(i)/60;
end
t = mean(time);
sd = std(time);
end