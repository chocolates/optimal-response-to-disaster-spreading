clear all
close all
rng(2)
flag = 2; % 1 for continous; 2 for discrete
model.strategy = 'S4';
for k = 1 : 20
    k
    initialise_param_and_X;
    X(model.idx, 1) = 4;

    [X, model] = forward(X, model, flag);
%     p_damaged_node(X, model, t_series)
    
    num = zeros(model.Nt + 1, 1);
    
    for i = 1 : model.Nt + 1
        num(i) = length(find(X(:, i) > model.theta));
    end
    
    if k == 1
        num_mean = 0.05 * num;
    else
        num_mean = num_mean + 0.05 * num;
    end
end

plot(t_series, num_mean)
xlabel('Time'); ylabel('Destroyed nodes')

initialise_param_and_X;
X(model.idx, 1) = 4;
[X, model] = forward(X, model, flag);
% for nt = 1 : model.Nt
%     x = X(:, nt);
%     
%     x2d = reshape(x, 20, 25);
% %     for i = 1 : 20
% %         for j = 1 : 25
% %             if x2d(i, j) > 0.5
% %                 x2d(i, j) = 5;
% %             end
% %         end
% %     end
%     
%     pcolor(x2d)
%     colorbar
%     axis equal
%     title(['nt = ', num2str(nt)])
% %     a = input('next');
%     pause(0.05)
% end

% plotX(X)

p_damaged_node(X, model, t_series)
check_op_strategy(model.Rt, model.Rit);


