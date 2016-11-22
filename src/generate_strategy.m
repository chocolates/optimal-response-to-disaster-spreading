function [ R_eachNode ] = generate_strategy( model, R_tol_at_t)
%generate resource distribution strategy
    if strcmp(model.strategy, 'S0')
        R_eachNode = zeros(1, model.NodeNumber);% no resources
    elseif strcmp(model.strategy, 'S1') % uniformly distribution
        R_eachNode = R_tol_at_t / model.NodeNumber * ones(1, model.NodeNumber);
    elseif strcmp(model.strategy, 'S2') % according to outdegree distribution
        normalizer = sum(model.outdegree);
        R_eachNode = R_tol_at_t / normalizer * model.outdegree;        
        
    elseif strcmp(model.strategy, 'S3') % uniform reinforcement of challenged nodes
        R_eachNode = zeros(1, model.NodeNumber);
        R_eachNode(find(model.state > 0)) = R_tol_at_t;
        num_challenged_node = length(find( model.state > 0));
        if num_challenged_node == 0
            R_eachNode = zeros(1, model.NodeNumber);
        else
            R_eachNode = R_eachNode / num_challenged_node;
        end
    elseif strcmp(model.strategy, 'S4') % first dameged, if not, challenged (uniformly)
        R_eachNode = zeros(1, model.NodeNumber);
        R_eachNode(find(model.state > 0.5)) = R_tol_at_t;
        num_challenged_node = length(find( model.state > 0.5));
        if num_challenged_node ~= 0
            R_eachNode = R_eachNode / num_challenged_node;
        else
            R_eachNode = zeros(1, model.NodeNumber);
            R_eachNode(find(model.state > 0)) = R_tol_at_t;
            num_challenged_node = length(find( model.state > 0));
            if num_challenged_node == 0
                R_eachNode = zeros(1, model.NodeNumber);
            else
                R_eachNode = R_eachNode / num_challenged_node;
            end
        end
%     elseif strcmp(model.strategy, 'S5')
        
    elseif strcmp(model.strategy, 'S6') % first damaged, if not, challenged (according to outdegree)
        R_eachNode = stratege_6(model, R_tol_at_t);
    else
        R_eachNode = zeros(1, model.NodeNumber);% no resources       
    end

end

