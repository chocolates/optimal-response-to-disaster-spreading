clear all
close all
format short g

%% initialization
initialise_parameters;

%% forward simulation 
% model = forward(model);

%% result
num_average = 5;
curve_ave = zeros(1, model.time_horizon+1);
for loop=1:num_average
    initialise_parameters;
    model = forward(model);
    curve_tmp = zeros(1, model.time_horizon+1);
    for i=1:model.time_horizon+1
        curve_tmp(i) = length(find(model.record_state(:, i) > 0.5));        
    end
    figure(loop)
    plot(curve_tmp(1:80));
    curve_ave = curve_ave + curve_tmp;
end
curve_ave = curve_ave / num_average;
figure;
plot( 1:80, curve_ave(1:80));
% plot(num);
title(['Strategy = ', num2str(model.strategy)], 'FontSize',18)
xlabel('time horizon','FontSize',16)
ylabel('damaged nodes', 'FontSize',16)