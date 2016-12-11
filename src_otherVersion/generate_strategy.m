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
    elseif strcmp(model.strategy, 'S5')
        q = 0.15;
        k = 0.8;
        num_highly_connect_nodes = floor(q * model.NodeNumber);
        [temp, I] = sort(model.outdegree, 'descend');
        I_high = I(1 : num_highly_connect_nodes);
        I_low = I(num_highly_connect_nodes+1 : end);
        R_eachNode = zeros(1, model.NodeNumber);
        R_eachNode(I_high) = k * R_tol_at_t / num_highly_connect_nodes;
        if isempty(model.state(I_low) > 0.5)
            R_eachNode(I_low) = (1 - k) * R_tol_at_t / (model.NodeNumber - num_highly_connect_nodes);
        else
            I_damaged = find(model.state(I_low) > 0.5);
            num_damaged = length(I_damaged);
            I_low_influenced = I_low(I_damaged);
            R_eachNode(I_low_influenced) = (1 - k) * R_tol_at_t / num_damaged;
        end
    elseif strcmp(model.strategy, 'S6') % first damaged, if not, challenged (according to outdegree)
        R_eachNode = stratege_6(model, R_tol_at_t);
    else
        R_eachNode = zeros(1, model.NodeNumber);% no resources       
    end

end

