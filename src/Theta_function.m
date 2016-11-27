function [ theta_y ] = Theta_function( y, model)
%the cohesion (theta) function in dynamic function
    
    alpha = model.alpha;
    numerator = 1 - exp( - alpha * y );
    denominator = 1 + exp( - alpha * ( y - 0.5 ));
    theta_y = numerator ./ denominator;
    
%     theta_y = y;    
    
end

