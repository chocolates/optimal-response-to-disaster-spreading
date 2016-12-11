function [ X_adj ] = Adams_bashforth_adjoint( X_adj, X, nt, model )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if nt >= 1
        X_adj(:, nt) = X_adj(:, nt + 1) + model.dt * adjoint_rhs(X_adj, X, nt + 1, model, 0);
        if nt <= round(model.Nt / 10)
            X_adj(model.idx, nt) = X_adj(model.idx, nt + 1);
        end
    else
        error('nt to initial !!!')
    end


end

