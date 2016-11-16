function [ M ] = generate_smallworld_network()
% K = 6 (connected to the 6 nearest neighbors)
    num_nodes = 500;
    K  = 6;
    p1 = 0.3; % the Prob to become a clock edge
    p2 = 0.3; % the Prob to become a counter-clock edge
    p3 = 1 - p1 - p2; % the Prob to become a bidirectional edge
    rewiring_prob = 0.3;
    
    M = zeros(num_nodes, num_nodes);
    
    % for each node i, concentrate the K/2 edges from i to j, such that j >
    % i
    for i=1:num_nodes
        for j=1:K/2
           node1_id = i;
           node2_id = rem(i+j, num_nodes);
           if node2_id == 0
               node2_id = num_nodes;
           end
           rnd1 = rand;
           if 0< rnd1 && rnd1 < p1 % clock edge
               node_i = node1_id;
               node_j = node2_id;
               
               rnd2 = rand;
               if rnd2 < rewiring_prob
                   % rewire
                   rand_k = randi([1, num_nodes]);
                   while rand_k == node_i || M(node_i, rand_k)~= 0
                       rand_k = randi([1, num_nodes]);
                   end
                   M(node_i, rand_k) = 0.5;
               else
                   % not rewire
                   M(node_i, node_j) = 0.5;
               end
               
           elseif p1 <= rnd1 && rnd1 < p1 + p2
               node_i = node2_id;
               node_j = node1_id;
               
               rnd2 = rand;
               if rnd2 < rewiring_prob
                   % rewire
                   rand_k = randi([1, num_nodes]);
                   while rand_k == node_i || M(node_i, rand_k) ~= 0
                       rand_k = randi([1, num_nodes]);
                   end
                   M(node_i, rand_k) = 0.5;
               else
                   % not rewire
                   M(node_i, node_j) = 0.5;
               end
                          
           else
               node_i = node1_id;
               node_j = node2_id;
               
               rnd2 = rand;
               if rnd2 < rewiring_prob
                   % rewire
                   rand_k = randi([1, num_nodes]);
                   while rand_k == node_i || M(node_i, rand_k)~= 0
                       rand_k = randi([1, num_nodes]);
                   end
                   M(node_i, rand_k) = 0.5;
               else
                   % not rewire
                   M(node_i, node_j) = 0.5;
               end
               
               
               node_i = node2_id;
               node_j = node1_id;

               rnd2 = rand;
               if rnd2 < rewiring_prob
                   % rewire
                   rand_k = randi([1, num_nodes]);
                   while rand_k == node_i || M(node_i, rand_k) ~= 0
                       rand_k = randi([1, num_nodes]);
                   end
                   M(node_i, rand_k) = 0.5;
               else
                   % not rewire
                   M(node_i, node_j) = 0.5;
               end
               
           end
        end
    end

end

