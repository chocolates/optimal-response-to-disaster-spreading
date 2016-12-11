function [ X, model ] = forward( X, model, flag )
% Forward simulation
        
    for nt = 2 : model.Nt + 1
        if flag == 1
            model = generate_strategy(X(:, nt - 1), nt, model, flag);
            model.R_cum_now = model.R_cum_it(:, nt - 1);
   
        elseif flag == 2 && mod(nt, 100) == 1
            model = generate_strategy(X(:, nt - 1), nt, model, flag);
            model.R_cum_now = model.R_cum_it(:, floor((nt - 2)/100) + 1);
%             plot(model.R_cum_now); hold on
        end
%         if mod(nt, 100) == 0
%             disp(['-------time step: ', num2str(nt - 1), '-------  nt = ', num2str(nt)]);
%         end
        X = Adams_bashforth_forward( X, nt, model );
        
    end
    
    disp('---------- Forward simulation done ----------')


end

