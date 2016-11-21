function [ R_eachNode ] = generate_strategy( model, R_tol_at_t)
%generate resource distribution strategy
    if strcmp(model.strategy, 'S0')
        R_eachNode = zeros(1, model.NodeNumber);% no resources
    elseif strcmp(model.strategy, 'S1')
        R_eachNode = R_tol_at_t / model.NodeNumber * ones(1, model.NodeNumber);
%     elseif strcmp(model.strategy, 'S2')

        
    elseif strcmp(model.strategy, 'S3')
        R_eachNode = zeros(1, model.NodeNumber);
        R_eachNode(find(model.state > 0)) = R_tol_at_t;
        num_challenged_node = length(find( model.state > 0));
        if num_challenged_node == 0
            R_eachNode = zeros(1, model.NodeNumber);
        else
            R_eachNode = R_eachNode / num_challenged_node;
        end
%     elseif strcmp(model.strategy, 'S4')
%         R_eachNode = zeros(1, model.NodeNumber);
%         R_eachNode(find(state_vector > 0.5)) = R_tol_at_t;
%         num_challenged_node = length(find( state_vector > 0.5));
%         if num_challenged_node ~= 0
%             R_eachNode = R_eachNode / num_challenged_node;
%         else
%             R_eachNode = zeros(1, model.NodeNumber);
%             R_eachNode(find(state_vector > 0)) = R_tol_at_t;
%             num_challenged_node = length(find( state_vector > 0));
%             if num_challenged_node == 0
%                 R_eachNode = zeros(1, model.NodeNumber);
%             else
%                 R_eachNode = R_eachNode / num_challenged_node;
%             end
%         end
    else
        R_eachNode = zeros(1, model.NodeNumber);% no resources       
    end

end

