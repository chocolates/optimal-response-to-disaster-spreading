function [ f ] = dissipation( M )
%The dissipation due to highly connected nodes
%   
    for i = 1 : size(M, 1)
        outd(i) = length(find(M(i, :) > 0));
    end
    
    f = 4 * outd ./ (1 + 3 * outd);


end

