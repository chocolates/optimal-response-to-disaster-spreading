clear all
close all
format short g

%% initialization
initialise_parameters;

%% forward simulation 
% model = forward(model);

%% result
num_average = 50;
curve_ave = zeros(1, model.time_horizon+1);
rng(2);
for loop=1:num_average
    loop
    initialise_parameters;
    model = forward(model);
    curve_tmp = zeros(1, model.time_horizon+1);
    for i=1:model.time_horizon+1
        curve_tmp(i) = length(find(model.record_state(:, i) > 0.5));        
    end
    figure(loop)
    plot(1:100, curve_tmp(1:100));
    curve_ave = curve_ave + curve_tmp;
end
curve_ave = curve_ave / num_average;

csvwrite(['average_curve_', model.strategy, '.dat'], curve_ave);
% 
figure(num_average+1);
plot(1:100, curve_ave(1:100));
title(['Strategy = ', num2str(model.strategy)], 'FontSize',18)
xlabel('time horizon','FontSize',16)
ylabel('damaged nodes', 'FontSize',16)