function [ ] = p_damaged_node( X, model )
%plot the curve of number of demaged nodes
    num = zeros(1, model.TimeStep);
    for i=1:model.TimeStep
        num(i) = length(find(X(:, i) > 0.5));        
    end
    plot(num(1:80));
    
    
end

