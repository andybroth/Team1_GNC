
function fig = plot_planar_pro(state_PRO, N)
    fig = figure;
    grid on 
    hold on
    subplot(2,2,1)
    hold on;
    for i = 1:N
        plot(state_PRO(i,:,1), state_PRO(i,:,2), 'DisplayName', "PRO "+i);
    end
    grid on 
    plot(0,0,'*','DisplayName', 'Cygnus');
    title('X-Y plane')
    legend()

    subplot(2,2,2)
    hold on
    for i = 1:N
        plot(state_PRO(i,:,2), state_PRO(i,:,3), 'DisplayName', "PRO "+i);
    end
    grid on 
    plot(0,0,'*');
    title('Y-Z plane')

    subplot(2,2,3)
    hold on
    for i = 1:N
        plot(state_PRO(i,:,1), state_PRO(i,:,3), 'DisplayName', "PRO "+i);
    end
    grid on 
    plot(0,0,'*');
    title('X-Z plane')

    subplot(2,2,4)
    hold on
    for i = 1:N
        plot3(state_PRO(i,:,1), state_PRO(i,:,2), state_PRO(i,:,3), 'DisplayName', "PRO "+i);
    end
    grid on 
    plot3(0,0,0,'*');
    title('X-Y-Z plane')
end