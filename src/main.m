clear all
close all
 
adj = 0;% 1 use adjoint; 0 do not use adjoint
max_iter = 1; % #iterations in optimization
flag = 2; % 1 for continuous, 2 for discrete

res = 10.; % residue of gradient
obj = 1e+10; % value of objective function
eps = 1e-10; % residue criteria
a = 20; % a in objective function

model.strategy = 'S1';
model.delta = 0.001; % step size in gradient descent
iter = 1;

while res > eps && iter <= max_iter
    % initialise or reset X value
    if iter == 1
        initialise_param_and_X;
        model.idx = 166;
%         model.idx = 115;
        X(model.idx, 1) = 4;
%       
        
    else
        X = zeros(model.Nnode, model.Nt);
        X(model.idx, 1) = model.tau;
    end
    
    [X, model] = forward(X, model, flag);
    check_op_strategy(model.Rt, model.Rit);
%     temp = model.Rit; save('benchmark_network/strategy_S6.dat', 'temp', '-ascii')
%     temp = model.M; save('benchmark_network/M_sf.dat', 'temp', '-ascii')
%     max(max(X))
    if iter == 1
        model.strategy = 'op';
    end
    if sum(X(:, end)) > obj
        model.delta = model.delta/2;
    end
    obj = sum(X(:, end)); % objective function
%     obj = sum((1 - exp(-a * X(:, end))) ./ (1 + exp(-a * (X(:, end) - model.theta))));
    disp(['iter = ', num2str(iter), 'objective function value: ', num2str(obj)])
    
    if res < 1e-3 % 5e-4
        model.delta = 0.005; % step in gradient descent
    end
    
    if adj == 1
%         initial condition of adjoint equation
        X_adj = zeros(model.Nnode, model.Nt + 1); 
        
        X_adj(:, end) = -1; % initial condition
%         X_adj(:, end) = -a * (exp(-a * X(:, end)) + exp(-a * (X(:, end) - model.theta))) ...
%             ./ (1 + exp(-a * (X(:, end) - model.theta))) .^ 2; % initial condition for adjoint
        
%         TODO: adjoint integration
        [X_adj, model] = adjoint(X_adj, X, model);
%         TODO: calculate the gradient, integration
        update = gradient(X, X_adj, model);
%         calculate residue
        res = norm(reshape(update, 50 * model.Nnode, 1))
%         plot(reshape(update, 50 * model.Nnode, 1))
%         update !
        model.Rit(:, model.tD + 1 : model.tD + 50) = model.Rit(:, model.tD + 1 : model.tD + 50) + update;
        model.R_cum_it = zeros(model.Nnode, model.Nt / 100 + 1);
        for i = 2 : model.Nt / 100 + 1
            model.R_cum_it(:, i) = model.R_cum_it(:, i - 1) + model.Rit(:, i);
        end
        check_op_strategy(model.Rt, model.Rit);
    end
    
    if res < eps
        disp('Optimization done: converged')
    end
    
    
    if iter == 1 || iter == max_iter || res < eps
%         p_damaged_node(X, model, t_series); hold on;
          plot(sort(X(:, end))); hold on
    end
    
    iter = iter + 1;
    if iter > max_iter
        disp('Optimization done: max iteration reached')
    end
    
end

save(['SF', '_', 'S0', '_X.dat'], 'X');

legend('ini', 'optimized');
xlabel('t')
ylabel('number of damaged nodes')
title(['optimization from', model.strategy, 'strategy'])
hold off
