function [ X_adj, model ] = adjoint( X_adj, X, model )
%Adjoint simulation

    for nt = model.Nt : -1 : 1
        model.R_cum_now = model.R_cum_it(:, floor(nt / 100) + 1);
%         if mod(nt, 100) == 0
%             disp(['-------time step: ', num2str(nt - 1), '-------  nt = ', num2str(nt)]);
%         end
        X_adj = Adams_bashforth_adjoint( X_adj, X, nt, model );
        
    end

    disp('---------- Adjoint simulation done ----------')


end

