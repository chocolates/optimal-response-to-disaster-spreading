function [M] = generate_grid_network()
    num_row = 25;
    num_col = 20;
    num_nodes = num_row * num_col;

    M = zeros(num_nodes, num_nodes);

    for row_id = 1:num_row
        for col_id = 1:num_col
            previous_ones = (row_id - 1) * num_col;
            node_id = col_id + previous_ones;

            % the left neighbor
            if col_id > 1
                left_neighbor_id = node_id - 1;
                M(node_id, left_neighbor_id) = 0.5;
            end
            % the right neighbor
            if col_id < num_col
                right_neighbor_id = node_id + 1;
                M(node_id, right_neighbor_id) = 0.5;
            end
            % the upper neighbor
            if row_id > 1
                upper_neighbor_id = node_id - num_col;
                M(node_id, upper_neighbor_id) = 0.5;
            end
            % the lower neighbor
            if row_id < num_row
                lower_neighbor_id = node_id + num_col;
                M(node_id, lower_neighbor_id) = 0.5;
            end

        end
    end


    % csvwrite('grid_network.dat', M);

end