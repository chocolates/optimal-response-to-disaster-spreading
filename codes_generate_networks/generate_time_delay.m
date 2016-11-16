function [ M, T ] = generate_time_delay(network_type)
%generate time delay t_{ij}, network_type is in {'grid', 'random', 'SF', 'SW'}
%   if there is a link from i to j, then t_{i,j} > 0; else t_{i,j} = 0

    
    %M = zeros(1,1);
    if strcmp(network_type, 'grid')
        M = generate_grid_network();
    elseif strcmp(network_type, 'random')
        M = generate_random_network();
    elseif strcmp(network_type, 'SF')
        M = generate_scalefree_network();
    else
        M = generate_smallwork_network();
    end
    
    [num_row, num_col] = size(M);
   
    T = 1000000000 * ones(num_row, num_col);
    
    for i=1:num_row
        for j=1:num_col
            if M(i,j) ~= 0
                T(i,j) = 0.05 * chi2rnd(4) + 1.2;
            end
        end
    end

end

