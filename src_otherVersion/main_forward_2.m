clear all
close all
format short g
rng(2);

strategy_names = {'S0', 'S1', 'S2', 'S3', 'S4', 'S5', 'S6'};
network_names = {'grid', 'SF'};

for loop1 = 1:length(network_names)
    networkType = network_names(loop1);
    networkType = char(networkType)
    for loop2 = 1:length(strategy_names)
        strategyType = strategy_names(loop2);
        strategyType = char(strategyType)
        
        num_average = 500;
        all_curves = zeros(num_average, 101);
        for loop=1:num_average
            initialise_parameters;
            model.NetworkType = networkType;
            model.strategy = strategyType;
            model = forward(model);
            curve_tmp = zeros(1, model.time_horizon+1);
            for i=1:model.time_horizon+1
                curve_tmp(i) = length(find(model.record_state(:, i) > 0.5));        
            end
            if loop==1
                curve_ave = zeros(1, model.time_horizon+1);
            end
            curve_ave = curve_ave + curve_tmp;
            all_curves(loop, :) = curve_tmp;
        end
        curve_ave = curve_ave / num_average;
        csvwrite([model.NetworkType, '_average_curve_', model.strategy, '.dat'], curve_ave);
        save([model.NetworkType, '_all_curves_', model.strategy, '.dat'], 'all_curves');            
    end        
end