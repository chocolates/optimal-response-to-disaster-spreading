function [ M ] = generate_random_network( )
%generate ER random network
    p = 0.0072; % Prob to form a link
    num_nodes = 500;
    M = zeros(num_nodes, num_nodes);
    
    for i=1:num_nodes
        for j=1:num_nodes            
            if i==j
                continue;
            end
            rnd = rand;
            
            if rnd <= p
                M(i, j) = 0.5;
            end
            
        end
    end

end

