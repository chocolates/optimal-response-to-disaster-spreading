function [ update ] = gradient( X, X_adj, model )
%Compute the update of strategy, i.e. the gradient
%   Detailed explanation goes here

    Nnode = model.Nnode;
    dt = model.dt;
    Nr = (length(model.Rt) - 1) / 2;
    tau = model.tau;
    beta2 = model.beta2;
    alpha2 = model.alpha2;
    
    update = zeros(Nnode, Nr);
    
    for i = 1 : Nnode
        
        if i ~= model.idx
            for t = Nr + 1 : -1 : 2
                t_idx = t * 100 + model.tD / dt + 1;

                if t == Nr + 1
                    R_cum_temp = ones(1, model.Nt - t_idx + 2);
                    for nt = t_idx : model.Nt + 1
                        R_cum_temp(nt - t_idx + 1) = model.R_cum_it(i, floor((nt - 1)/100) + 1);
                    end
%                     t_idx
%                     size(R_cum_temp)
  
                    w = ones(1, model.Nt - t_idx + 2);
                    w(1) = 0.5; w(end) = 0.5;

                    tau_i = (tau - beta2) * exp(-alpha2 * R_cum_temp) + beta2;
%                     size(tau_i)
                    
                    update(i, t - 1) = sum(1 ./ tau_i.^2 .* (tau_i - beta2) * alpha2 .* w * dt ...
                        .* X(i, t_idx : end) .* X_adj(i, t_idx : end));
                else
                    w = ones(1, 100);
                    w(1) = 0.5;
                    tau_i = (tau - beta2) * exp(-alpha2 * model.R_cum_it(i, t)) + beta2;
                    update(i, t - 1) = sum(1 / tau_i^2 * (tau_i - beta2) * alpha2 .* w * dt ...
                        .* X(i, t_idx : t_idx + 99) .* X_adj(i, t_idx : t_idx + 99)) + ...
                        update(i, t);
                end
            end
            
        else
            for t = Nr + 1 : -1 : 2
                t_idx = max(10 / dt + 1, t * 100 + model.tD / dt + 1);
                
                if t - 1 + model.tD >= 10
                    if t == Nr + 1
                        R_cum_temp = ones(1, model.Nt - t_idx + 2);
                        for nt = t_idx : model.Nt + 1
                            R_cum_temp(nt - t_idx + 1) = model.R_cum_it(i, floor((nt - 1)/100) + 1);
                        end
        %                     t_idx
        %                     size(R_cum_temp)

                        w = ones(1, model.Nt - t_idx + 2);
                        w(1) = 0.5; w(end) = 0.5;

                        tau_i = (tau - beta2) * exp(-alpha2 * R_cum_temp) + beta2;
        %                     size(tau_i)

                        update(i, t - 1) = sum(1 ./ tau_i.^2 .* (tau_i - beta2) * alpha2 .* w * dt ...
                            .* X(i, t_idx : end) .* X_adj(i, t_idx : end));
                    else
                        w = ones(1, 100);
                        w(1) = 0.5;
                        tau_i = (tau - beta2) * exp(-alpha2 * model.R_cum_it(i, t)) + beta2;
                        update(i, t - 1) = sum(1 / tau_i^2 * (tau_i - beta2) * alpha2 .* w * dt ...
                            .* X(i, t_idx : t_idx + 99) .* X_adj(i, t_idx : t_idx + 99)) + ...
                            update(i, t);
                    end
                end
            end
        end
    end
    
%     compute lambda_t
    lambda_t = - sum(update) / Nnode;
    
    for i = 1 : Nr
        update(:, i) = ones(Nnode, 1) * lambda_t(i) + update(:, i);
    end
    
    Rit_old = model.Rit(:, model.tD + 1 : model.tD + 50);
    
    Rit_new = model.Rit(:, model.tD + 1 : model.tD + 50) - model.delta * update;
    
    Rit_new(Rit_new < 0) = 0;

%     normalisation
    for i = 1 : 50
        Rit_new(:, i) = Rit_new(:, i) / sum(Rit_new(:, i)) * model.Rt(i + model.tD);
    end
    
    update = Rit_new - Rit_old;

end

