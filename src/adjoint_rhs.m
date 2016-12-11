function [ rhs ] = adjoint_rhs( X_adj, X, nt, model, flag )
%Compute the right-hand-side of the adjoint equation
%   Detailed explanation goes here

    alpha2 = model.alpha2;
    beta2 = model.beta2;
    tau = model.tau;
    theta = model.theta;

    t_old = nt + round(1.4 / model.dt); %model.delay;
    if t_old < model.Nt + 2
        X_adv = X_adj(:, t_old);
    else
        X_adv = zeros(model.Nnode, 1);
    end
    
    t_old = nt - round(1.4 / model.dt); %model.delay;
    if t_old > 0
        X_delay = X(:, t_old);
    else
        X_delay = zeros(model.Nnode, 1);
    end
    
    if flag == 1   
        K_term_adj = 0.25 * model.K * X_adv;
    end
    
    if flag == 0 % stand for adjoint sigmoidal function
        K_term_fwd = (X_delay' * model.K)';
        alpha = 20;
        K_term_adj = alpha * (exp(-alpha * K_term_fwd) + exp(-alpha * (K_term_fwd - theta))) ...
            ./ (1 + exp(-alpha * (K_term_fwd - theta))) .^ 2 .* (model.K * X_adv);
    end
        
    
    diagP = 1 ./ ((tau - beta2) * exp(-alpha2 * model.R_cum_now) + beta2);
   
    P_term = diagP .* X_adj(:, nt);
    rhs = K_term_adj - P_term;
    
%     rhs = - P * x;


end

