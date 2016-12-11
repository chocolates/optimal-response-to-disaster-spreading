% initialise parameters
model.theta = 0.5;
model.beta = 0.025;
model.alpha2 = 0.58;
model.beta2 = 0.2;
model.tau = 4;


% 0 - from an existed grid and time delay, 1 - start from random network
% flag = 0;
model.R_tot = 600;
model.tD = 8;
model.Nt = 10000;

[model.Rt, t_series] = generate_basic(model.Nt, model.R_tot, model.tD, flag);
model.dt = (t_series(2) - t_series(1));
if flag == 1
    model.ntD = model.tD / model.dt;
elseif flag == 2
    model.ntD = floor(model.tD / model.dt / 100);
end

if flag == 1
    % TODO generate the M matrix and time delay matrix delay
    [model.M] = generate_time_delay('grid');

    model.Nnode = size(model.M, 1);
    model.idx = randi([1, model.Nnode]);
    model.R_cum_now = zeros(model.Nnode, 1);

%     delay = delay / model.dt;
%     model.delay = round(delay);
    model.Rit = zeros(model.Nnode, model.Nt + 1);
    
    model.R_cum_it = zeros(model.Nnode, model.Nt + 1);
    for i = 2 : model.Nt + 1
        model.R_cum_it(:, i) = model.R_cum_it(:, i - 1) + model.Rit(:, i);
    end
    
elseif flag == 2
    
    % TODO generate the M matrix and time delay matrix delay
%     [model.M] = generate_time_delay('grid');
    model.M = load('benchmark_network/M_sf.dat');

    model.Nnode = size(model.M, 1);
    model.idx = randi([1, model.Nnode]);
%     model.idx = 1;
    model.R_cum_now = zeros(model.Nnode, 1);


%     delay = delay / model.dt;
%     model.delay = round(delay);
%    
    if strcmp(model.strategy, 'op')
        model.Rit = random_strategy(model.Rt, model.Nnode);
%         model.idx = 28;
%         model.idx = 166;
%         model.Rit = load('benchmark_network/strategy_S5.dat');
    else
        model.Rit = zeros(model.Nnode, model.Nt / 100 + 1);
    end
    
    model.R_cum_it = zeros(model.Nnode, model.Nt / 100 + 1);
    for i = 2 : model.Nt / 100 + 1
        model.R_cum_it(:, i) = model.R_cum_it(:, i - 1) + model.Rit(:, i);
    end
    
elseif flag == 0

    model.M = load('sample_networks/grid_network.dat');
    delay = load('benchmark_network/delay.dat');

    model.Nnode = size(model.M, 1);
    model.idx = randi([1, model.Nnode]);

    delay = delay / model.dt;
    model.delay = round(delay);
   
    if strcmp(model.strategy, 'op')
        [n, m] = size(model.strategy);
        if n ~= model.Nnode || m ~= model.Nt / 2 + 1
            error('Dim of strategy is wrong!')
        else
            model.Rit = model.strategy;
        end
    else
        model.Rit = zeros(model.Nnode, model.Nt + 1);
    end
    
    model.R_cum_it = zeros(model.Nnode, model.Nt + 1);
    for i = 2 : model.Nt + 1
        model.R_cum_it(:, i) = model.R_cum_it(:, i - 1) + model.Rit(:, i);
    end
    
else
    error('Input flag not correct: 0 or 1');
end

X = zeros(model.Nnode, model.Nt + 1);

% model.K = model.M .* exp(- model.beta * model.delay * model.dt);
model.K = model.M .* exp(- model.beta * 1.4);
for i = 1 : model.Nnode
    model.outd(i) = length(find(model.M(i, :)));
end
dissip = dissipation(model.M);
for j = 1 : model.Nnode
    if dissip(j) == 0
        model.K(j, :) = zeros(1, model.Nnode);
    else
        model.K(j, :) = model.K(j, :) / dissip(j);
    end
end

disp('------------finishing initialising-------------');
