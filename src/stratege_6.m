function [ R_eachNode ] = stratege_6( model, R_tol_at_t )
% first for damaged nodes, if no damaged nodes, then challenged nodes.
% According to outdegree distribution

    damaged_node_list = find(model.state > 0.5);
    challenged_node_list = find(model.state > 0);
    if length(damaged_node_list)>0
        damaged_outdegrees = model.outdegree(damaged_node_list);
        normalizer = sum(damaged_outdegrees);
        R_eachNode = zeros(1, model.NodeNumber);
        R_eachNode(damaged_node_list) = R_tol_at_t / normalizer * damaged_outdegrees;        
    elseif length(challenged_node_list) > 0
        challenged_outdegrees = model.outdegree(challenged_node_list);
        normalizer = sum(challenged_outdegrees);
        R_eachNode = zeros(1, model.NodeNumber);
        R_eachNode(challenged_node_list) = R_tol_at_t / normalizer * challenged_outdegrees;
    else
        R_eachNode = zeros(1, model.NodeNumber);        
    end
end

