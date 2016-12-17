load('grid_S0_X.dat', '-mat');
strategy1 = X;

%%
timesteps = 1:10001;
% plot_type = 1;% 'damaged';
plot_type = 2;% 'finalState';
if plot_type == 1
    result_0 = zeros(1, 10001);
    result_1 = zeros(1, 10001);
    result_2 = zeros(1, 10001);
    result_3 = zeros(1, 10001);
    result_4 = zeros(1, 10001);
    result_5 = zeros(1, 10001);
    result_6 = zeros(1, 10001);
    result_op_sigmoid = zeros(1, 10001);
    result_op_linear = zeros(1, 10001);
    for loop=1:10001
        result_0(loop) = length(find(strategy0(:, loop) > 0.5));
        result_1(loop) = length(find(strategy1(:, loop) > 0.5));
        result_2(loop) = length(find(strategy2(:, loop) > 0.5));
        result_3(loop) = length(find(strategy3(:, loop) > 0.5));
        result_4(loop) = length(find(strategy4(:, loop) > 0.5));
        result_5(loop) = length(find(strategy5(:, loop) > 0.5));
        result_6(loop) = length(find(strategy6(:, loop) > 0.5));
        result_op_sigmoid(loop) = length(find(strategy_obj_sigmoid(:, loop) > 0.5));
        result_op_linear(loop) = length(find(strategy_obj_linear(:, loop) > 0.5));
    end
    figure;
    hold on;
    % h0 = plot(timesteps, strategy0, 'ob');
    % h1 = plot(timesteps, strategy1,'-or');
    % h2 = plot(timesteps, strategy2,'-*g');
    % h3 = plot(timesteps, strategy3,'-sb');
    % h4 = plot(timesteps, strategy4,'-^y');
    % h6 = plot(timesteps, strategy6,'->k');
    timesteps = timesteps / 100.0;
    h0 = plot(timesteps, result_0, 'LineWidth',2);
    h1 = plot(timesteps, result_1, 'LineWidth',2);
    h2 = plot(timesteps, result_2, 'LineWidth',2);
    h3 = plot(timesteps, result_3, 'LineWidth',2);
    h4 = plot(timesteps, result_4, 'LineWidth',2);
    h5 = plot(timesteps, result_5, 'LineWidth',2);
    h6 = plot(timesteps, result_6, 'LineWidth',2);
    h7 = plot(timesteps, result_op_sigmoid, 'LineWidth', 2)
    legend([h0, h1,h2,h3,h4, h5, h6, h7],'no resource','strategy1','strategy2','strategy3','strategy4', 'strategy5', 'strategy6', 'sigmoid obj', 'Location', 'northwest');
    title('Different Strategies on Grid Network', 'FontSize',18)
    xlabel('time horizon','FontSize',16)
    
    ylabel('damaged nodes', 'FontSize',16)
    print(gcf,'-dpdf','Grid_damaged.pdf')
    
else
    figure;
    hold on;
%     h0 = plot(sort(strategy1(:, end)),'black', 'LineWidth',2);
%     h1 = plot(sort(strategy1(:, 7000)), 'LineWidth',2);
%     h2 = plot(sort(strategy1(:, 6000)), 'LineWidth',2);
%     h3 = plot(sort(strategy1(:, 4000)), 'LineWidth',2);
%     h4 = plot(sort(strategy1(:, 2000)), 'LineWidth',2);
%     h5 = plot(sort(strategy1(:, 1)), 'LineWidth',2);
    
    h0 = plot((strategy1(:, end)), 'o');
    h1 = plot((strategy1(:, 7000)), 'o');
    h2 = plot((strategy1(:, 6000)), 'o');
    h3 = plot((strategy1(:, 4000)), 'o');
    h4 = plot((strategy1(:, 2000)), 'o');
    h5 = plot((strategy1(:, 1)), 'o');
    legend([h0, h1, h2, h3, h4, h5],'States: t=100', 'States: t=70','States: t=60','States: t=40','States: t=20','States: t=0', 'Location', 'northeast');
%     h30 = plot( sort(opt_30(:, end)), 'LineWidth',2);
%     h60 = plot( sort(opt_60(:, end)), 'LineWidth',2);
%     h90 = plot( sort(opt_90(:, end)), 'LineWidth',2);
%     h120 = plot( sort(opt_120(:, end)), 'LineWidth',2);
%     h150 = plot( sort(opt_150(:, end)), 'LineWidth',2);
    
%     legend([h0, h30, h60, h90, h120, h150],'S2','opt: iter=30','opt: iter=60','opt: iter=90','opt: iter=120', 'opt: iter=150', 'Location', 'northwest');
%     title('Different Strategies on Grid Network', 'FontSize',18)
    xlabel('nodes','FontSize',16)
    
    ylabel('states', 'FontSize',16)
    axis([0,500, 0 , 4])
%     print(gcf,'-dpdf','Grid_S0_States.pdf')
end