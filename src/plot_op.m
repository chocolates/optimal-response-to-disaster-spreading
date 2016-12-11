clear all
close all

flag = 2; % 1 for continuous, 2 for discrete
for n = 3 : 7
    if n < 7
        model.strategy = ['S', num2str(n)];
        initialise_param_and_X;
        model.idx = 28;
        X(model.idx, 1) = 4;
        [X, model] = forward(X, model, flag);
        obj = sum(X(:, end));
        disp(['objective function value: ', num2str(obj)])
        p_damaged_node(X, model, t_series); hold on;
    else
        model.strategy = 'op';
        model.Rit = load('benchmark_network/op_strategy.dat');
        model.Rit = model.Rit * 1000 / 120;
        model.R_cum_it = zeros(model.Nnode, model.Nt / 100 + 1);
        for i = 2 : model.Nt / 100 + 1
            model.R_cum_it(:, i) = model.R_cum_it(:, i - 1) + model.Rit(:, i);
        end
        check_op_strategy(model.Rt, model.Rit);
        
        X = zeros(model.Nnode, model.Nt + 1);
        X(model.idx, 1) = 4;
        [X, model] = forward(X, model, flag);
        obj = sum(X(:, end));
        disp(['objective function value: ', num2str(obj)]);
    end
end

% adj = 1;
% max_iter = 101;
% 
% res = 10.;
% obj = 1e+10;
% eps = 0.0001;
% 
% model.strategy = 'op';
% model.delta = 0.001;
% iter = 1;
% 
% while res > eps && iter <= max_iter
%     % initialise or reset X value
%     if iter == 1
%         initialise_param_and_X;
%         model.idx = 28;
%         X(model.idx, 1) = 4;
% %         check_op_strategy(model.Rt, model.Rit);
%         
%     else
%         X = zeros(model.Nnode, model.Nt + 1);
%         X(model.idx, 1) = model.tau;
%     end
%     
%     [X, model] = forward(X, model, flag);
%     if iter == 1
%         check_op_strategy(model.Rt, model.Rit);
%     end
% %     temp = model.Rit; save('benchmark_network/strategy_S6.dat', 'temp', '-ascii')
% %     temp = model.M; save('benchmark_network/M_sf.dat', 'temp', '-ascii')
% %     max(max(X))
% %     if iter == 1
% %         model.strategy = 'op';
% %     end
%     if sum(X(:, end)) > obj
%         model.delta = model.delta/2;
%     end
%     obj = sum(X(:, end));
%     disp(['objective function value: ', num2str(obj)])
%     
%     if adj == 1
% %         initial condition of adjoint equation
%         X_adj = zeros(model.Nnode, model.Nt + 1);
%         X_adj(:, end) = -1;
% %         TODO: adjoint integration
%         [X_adj, model] = adjoint(X_adj, model);
% %         TODO: calculate the gradient, integration
%         update = gradient(X, X_adj, model);
% %         calculate residue
%         res = norm(reshape(update, 50 * model.Nnode, 1))
% %         plot(reshape(update, 50 * model.Nnode, 1))
% %         update !
%         model.Rit(:, model.tD + 1 : model.tD + 50) = model.Rit(:, model.tD + 1 : model.tD + 50) + update;
%         model.R_cum_it = zeros(model.Nnode, model.Nt / 100 + 1);
%         for i = 2 : model.Nt / 100 + 1
%             model.R_cum_it(:, i) = model.R_cum_it(:, i - 1) + model.Rit(:, i);
%         end
%         check_op_strategy(model.Rt, model.Rit);
%     end
%     
%     if res < eps
%         disp('Optimization done: converged')
%     end
%     
%     
% %     if iter == 1 || iter == max_iter || res < eps
% %         p_damaged_node(X, model, t_series); hold on;
% %     end
%     
%     iter = iter + 1;
%     if iter > max_iter
%         disp('Optimization done: max iteration reached')
%     end
%     
% end
% temp = model.Rit;
% save('benchmark_network/op_strategy.dat', 'temp', '-ascii');

p_damaged_node(X, model, t_series);
xlabel('t')
ylabel('number of damaged nodes')
title('optimization from random distribution of resources')
legend('S3', 'S4', 'S5', 'S6', 'optimal')
hold off
