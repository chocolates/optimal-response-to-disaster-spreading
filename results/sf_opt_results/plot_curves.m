

nettype = 'SF_';

load('SF_S0_X.dat', '-mat');
strategy0 = X;

load('SF_S1_X.dat', '-mat');
strategy1 = X;


load('SF_S2_X.dat', '-mat');
strategy2 = X;

load('SF_S3_X.dat', '-mat');
strategy3 = X;

load('SF_S4_X.dat', '-mat');
strategy4 = X;

load('SF_S5_X.dat', '-mat');
strategy5 = X;

load('SF_S6_X.dat', '-mat');
strategy6 = X;

load('SF_op_sigmoid_obj_X.dat', '-mat');
strategy_obj_sigmoid = X;

load('SF_op_linear_obj_X.dat', '-mat');
strategy_obj_linear = X;


%%
timesteps = 1:10001;
plot_type = 1;% 'damaged';
% plot_type = 2;% 'finalState';
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
    legend([h0, h1,h2,h3,h4, h5, h6, h7],'no resource','strategy1','strategy2','strategy3','strategy4', 'strategy5', 'strategy6', 'sigmoid obj', 'Location', 'northeast');
    title('Different Strategies on SF Network', 'FontSize',18)
    xlabel('time horizon','FontSize',16)
    
    ylabel('damaged nodes', 'FontSize',16)
    print(gcf,'-dpdf','SF_damaged.pdf')
    
else
    figure;
    hold on;
    h0 = plot(sort(strategy0(:, end)), 'LineWidth',2);
    h1 = plot( sort(strategy1(:, end)), 'LineWidth',2);
    h2 = plot( sort(strategy2(:, end)), 'LineWidth',2);
    h3 = plot( sort(strategy3(:, end)), 'LineWidth',2);
    h4 = plot( sort(strategy4(:, end)), 'LineWidth',2);
    h5 = plot( sort(strategy5(:, end)), 'LineWidth',2);
    h6 = plot(sort(strategy6(:, end)), 'LineWidth',2);
    h7 = plot( sort(strategy_obj_linear(:, end)), 'LineWidth',2);
    legend([h0, h1,h2,h3,h4, h5, h6, h7],'no resource','strategy1','strategy2','strategy3','strategy4', 'strategy5', 'strategy6', 'linear obj', 'Location', 'northwest');
    title('Different Strategies on SF Network', 'FontSize',18)
    xlabel('nodes','FontSize',16)
    
    ylabel('final state', 'FontSize',16)
    print(gcf,'-dpdf','SF_finalState.pdf')
end