function [ Rit ] = random_strategy( Rt, Nnode )
%Generate random strategy for optimization purpose
%   Detailed explanation goes here

    Nt = length(Rt);
    Rit = zeros(Nnode, Nt);
    for i = 1 : Nt
        r = rand(Nnode);
        Rit(:, i) = r / sum(r) * Rt(i);
    end
    
end

