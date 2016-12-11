function [ ] = plotX( X )
% plot X

    [Nnode, Nt] = size(X);
    node = 1 : Nnode;
    
    figure
    for i = 1 : Nt
        plot(X(:, i) + i - 1, node,  '-k')
        hold on
    end
    hold off
    


end

