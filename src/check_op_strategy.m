function [  ] = check_op_strategy( Rt, strategy )
%   Check the input strategy of optimization 
%   Detailed explanation goes here

    if norm(sum(strategy) - Rt') > 0.01
        error('The input strategy is not correct !');
    else
%         disp('strategy correct');
    end

end

