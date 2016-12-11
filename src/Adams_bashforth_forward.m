function [ X ] = Adams_bashforth_forward( X, nt, model )
% Time itegration of the forward equation to time step nt
% For the sake of running time, use Euler's method.

    if nt <= model.Nt + 1

        X(:, nt) = X(:, nt - 1) + model.dt * forward_rhs(X, nt - 1, model, 0);
        if nt <= round(model.Nt / 10)
            X(model.idx, nt) = model.tau;
        end

    else
        error('AD: nt to the end !!!')
    end
        
%     elseif strcmp(type, 'adjoint')
%         if nt >= 1
%             
%             X(:, nt) = X(:, nt + 1) + model.dt * adjoint_rhs(X, nt + 1, model, 0);
%             if nt <= round(model.Nt / 10)
%                 X(model.idx, nt) = X(model.idx, nt + 1);
%             end
%         else
%             error('nt to initial !!!')
%         end
%     end
        
    
end

