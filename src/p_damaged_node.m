function [ ] = p_damaged_node( X, model, t )
%

%     figure
    
    num = zeros(model.Nt + 1, 1);
    
    for i = 1 : model.Nt + 1
        num(i) = length(find(X(:, i) > model.theta));
    end
    
    plot(t, num, 'LineWidth', 2)
    xlabel('Time'); ylabel('Destroyed nodes')


end

