function [ M ] = generate_scalefree_network( )
%generate directed scale free network,
    num_nodes = 500;
    alpha = 0.1;
    beta = 0.8;
    % gamma = 0.1;
    delta_in = 2;
    delta_out = 2;
    
    in_degrees = [];
    out_degrees = [];
    M = zeros(num_nodes, num_nodes);
    
    % G0 is a single vertex with no edge
    in_degrees(1) = delta_in;
    out_degrees(1) = delta_out;
    count_node_num = 1;
        
    while count_node_num < num_nodes
        rnd = rand;
        if 0 <= rnd && rnd < alpha
            % the first case
            count_node_num = count_node_num + 1;
            node1_id = count_node_num;
            prob = in_degrees / sum(in_degrees);
            r = rand;
            node2 = sum(r >= cumsum([0, prob]));
            
            M(node1_id, node2) = 1;
            in_degrees(node2)  = in_degrees(node2) + 1;
            in_degrees(node1_id) = delta_in;
            out_degrees(node1_id) = delta_out + 1;
            
        elseif alpha <= rnd && rnd < alpha + beta
            % the second case
            prob1= in_degrees / sum(in_degrees);
            r = rand;
            node2 = sum(r >= cumsum([0, prob1]));
            
            prob2 = out_degrees / sum(out_degrees);
            r = rand;
            node1 = sum(r >= cumsum([0, prob2]));
            
            M(node1, node2) = 1;
            in_degrees(node2)  = in_degrees(node2) + 1;
            out_degrees(node1) = out_degrees(node1) + 1;
        else
            % the third case
            count_node_num = count_node_num + 1;
            node2_id = count_node_num;
            prob = out_degrees / sum(out_degrees);
            r = rand;
            node1 = sum(r >= cumsum([0, prob]));
            M(node1, node2_id)= 1;
            out_degrees(node1) = out_degrees(node1) + 1;
            in_degrees(node2_id) = delta_in + 1;
            out_degrees(node2_id) = delta_out;
        end                        
    end
    
    for i=1:num_nodes
        for j=1:num_nodes
            if j == i
                M(i, j) = 0;
            else
                if M(i, j) == 1
                    M(i, j) = 0.5;
                end
            end
            
        end
    end
end

