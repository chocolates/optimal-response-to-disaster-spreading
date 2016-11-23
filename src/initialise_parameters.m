

%% parameters % initialise_param_and_X;
addpath(genpath('../codes_generate_networks'));
model.NodeNumber = 500;
model.NetworkType = 'grid';
disp(['network type is ' model.NetworkType]);
[model.M, model.delay] = generate_time_delay(model.NetworkType);
if size(model.M, 1) ~= model.NodeNumber || size(model.M, 2) ~= model.NodeNumber
    error('Dim of Adjacent Matrix is wrong!');
end
model.outdegree = zeros(1, model.NodeNumber);
for i=1:model.NodeNumber
    model.outdegree(i) = length(find(model.M(i, :) > 0));
end

model.dt = 0.01;
model.time_horizon = 100;
model.TimeStep = model.time_horizon / model.dt;
if rem(model.time_horizon, model.dt) ~=0
    error('model.time_horizon should be multiple of model.dt!');
end

model.state = zeros(1, model.NodeNumber);
model.record_state = zeros(model.NodeNumber, model.time_horizon+1); % record internal states at t=1,2,3,...,101
model.All_States = zeros(model.NodeNumber, model.TimeStep + 1);
model.idx = randi(model.NodeNumber); % idx
% model.idx = 1;

disp(['network size is: ' num2str(model.NodeNumber)]);
disp(['random chosen node is: ' num2str(model.idx)]);
model.Tau_start = 4;
model.state(model.idx) = model.Tau_start;
model.record_state(model.idx, 1) = model.Tau_start;

model.tD = 8;
model.strategy = 'S3'; % Strategy
model.Resource_accumulate = zeros(1, model.NodeNumber); % Cumulative Resources at beginning
model.R_tot = 1000;
model.Rt = generate_basic(model);

model.beta2 = 0.2;
model.alpha2 = 0.58;
model.Tau_start = 4;

model.theta = 0.5;
model.alpha = 20; % the "gain parameter" alpha in differential equation

model.beta = 0.025;
model.K = model.M .* exp( - model.beta * model.delay); % for the second term
model.K = model.M * exp(- model.beta * 1.4);
for i=1:model.NodeNumber
    denominator = 4 * model.outdegree(i) / (1 + 3 * model.outdegree(i));
    model.K(i, :)  = model.K(i, :) / denominator;
end