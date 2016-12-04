clear all
close all
format short g
rng(2);
%% initialization
% initialise_parameters;

%% forward simulation 
% model = forward(model);

%% result
num_average = 10;

for loop=1:num_average
    loop
    initialise_parameters;
    model = forward(model);
    curve_tmp = zeros(1, model.time_horizon+1);
    for i=1:model.time_horizon+1
        curve_tmp(i) = length(find(model.record_state(:, i) > 0.5));        
    end
%     figure(loop)
    figure;
    plot(1:model.time_horizon, curve_tmp(1:model.time_horizon));
%     figure;
%     plot(model.state, 'o');
    if loop==1
        curve_ave = zeros(1, model.time_horizon+1);
    end
    curve_ave = curve_ave + curve_tmp;
end
curve_ave = curve_ave / num_average;

csvwrite([model.NetworkType, '_average_curve_', model.strategy, '.dat'], curve_ave);
% 
% figure(num_average+1);
figure
plot(1:model.time_horizon, curve_ave(1:model.time_horizon));
title(['Strategy = ', num2str(model.strategy)], 'FontSize',18)
xlabel('time horizon','FontSize',16)
ylabel('damaged nodes', 'FontSize',16)