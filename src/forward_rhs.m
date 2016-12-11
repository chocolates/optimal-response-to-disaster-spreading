function [ rhs ] = forward_rhs( X, nt, model, flag )
%   compute the rhs of forward simulation
%   
    theta = model.theta;
    alpha2 = model.alpha2;
    beta2 = model.beta2;
    tau = model.tau;

%     K_term = delayx(X, nt, model);
    
%     disp(max(K_term))
    
    t_old = nt - round(1.4 / model.dt); %model.delay;
    if t_old > 0
        X_delay = X(:, t_old);
    else
        X_delay = zeros(model.Nnode, 1);
    end
    
    K_term = (X_delay' * model.K)';
       
    diagP = 1 ./ ((tau - beta2) * exp(-alpha2 * model.R_cum_now) + beta2);
    
%     use sigmoidal function for reproduce results
    if flag == 0
        alpha = 20;
        K_term = (1 - exp(-alpha * K_term)) ./ (1 + exp(-alpha * (K_term - theta)));
    end
    
    if flag == 10
        K_term = 0.25 * K_term;
    end
    P_term = diagP .* X(:, nt);
    rhs = K_term - P_term;
    
%     rhs = - P * x;

%     disp(max(abs(rhs)))
        
        
        

end

