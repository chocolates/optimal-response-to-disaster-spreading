%% initialize the network and time delay
addpath(genpath('../codes_generate_networks'));
model.NodeNumber = 500;
model.NetworkType = 'grid';
disp(['network type is ' model.NetworkType]);
[model.M, model.delay] = generate_time_delay(model.NetworkType);

if size(model.M, 1) ~= model.NodeNumber || size(model.M, 2) ~= model.NodeNumber
    error('Dim of Adjacent Matrix is wrong!');
end

%% generate resources at each time step
model.TimeStep = 100;
model.R_tot = 1000; % total resources
% model.Rt = generate_basic(model.R_tot, model.TimeStep); % the resources entering into the system at each time step

%% initialize the random node failed at beginning
model.idx = randi(model.NodeNumber);
disp(['network size is: ' num2str(model.NodeNumber)]);
disp(['random chosen node is: ' num2str(model.idx)]);

%% initialize state variables
model.beta2 = 0.2;
model.alpha2 = 0.58;
model.Tau_start = 4;
X = zeros(model.NodeNumber, model.TimeStep+1);
for t=1:10
    X(model.idx, t) = model.Tau_start;
end

