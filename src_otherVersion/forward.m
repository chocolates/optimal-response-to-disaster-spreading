function [ model ] = forward(model)
% simulation the spreading process

    % change the state variables
    
    
    delay = 1.4;
    K = model.K;
    for t=2:model.TimeStep+1
        t;
        real_time = (t - 1) * model.dt;
        if rem(real_time, 1) ==0
            model.record_state(:, real_time+1) = model.state';
        end
        if real_time - model.tD <= model.time_horizon/2 && real_time - model.tD > 0
            R_tol_at_t = model.Rt(t - model.tD/model.dt -1);
        else
            R_tol_at_t = 0;        
        end

        Resource_each_node_at_t = generate_strategy(model, R_tol_at_t);      
        model.Resource_accumulate = model.Resource_accumulate + Resource_each_node_at_t;
        model.R_each_node(:, t-1) = Resource_each_node_at_t;
        % iterate each node
        X_tmp1 = model.state;
        tau_t = (model.Tau_start - model.beta2) * exp(-model.alpha2 * model.Resource_accumulate) + model.beta2;
        first_term = - X_tmp1 ./tau_t;
        
        if t - delay/model.dt > 0
            X_tmp2 = model.All_States(:, t-1.4/model.dt)';
        else
            X_tmp2 = zeros(1, model.NodeNumber);
        end
        second_term = X_tmp2 * K;
        
%         X_tmp = model.state;
%         second_term = X_tmp * K;
        second_term = Theta_function(second_term, model);
%         tau_t = (model.Tau_start - model.beta2) * exp(-model.alpha2 * model.Resource_accumulate) + model.beta2;
%         first_term = - X_tmp ./tau_t;
        model.state = model.state + model.dt * (first_term + second_term);
        
        
        % begin{previous}
%         X_tmp = zeros(model.NodeNumber, 1); % the synchronized update
%         second_term = K * model.state';
%         second_term = Theta_function(second_term, model);
%         tau_t = (model.Tau_start - model.beta2) * exp(-model.alpha2 * model.Resource_accumulate) + model.beta2;
%         first_term = - model.state ./ tau_t;
%         X_tmp = model.state + model.dt * (first_term + second_term');
%         model.state = X_tmp;
    %     for i=1:model.NodeNumber
    %         model.Resource_accumulate(i) = model.Resource_accumulate(i) + Resource_each_node_at_t(i);
    %         tau_i_t = (model.Tau_start - model.beta2) * exp(-model.alpha2 * model.Resource_accumulate(i)) + model.beta2;
    %         second_term = dot(K(:, i) , X(:, t-1));
    %         second_term = Theta_function(second_term);
    %         X_tmp(i) = X(i, t-1) + (- X(i, t-1) / tau_i_t + second_term);
    %     end 
    %     \end{previous}
        if t-1 <= 10/model.dt
            model.state(model.idx) = model.Tau_start;
        end
        model.All_States(:, t) = model.state';
    end

end

