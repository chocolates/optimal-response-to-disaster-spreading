function [ theta_y ] = Theta_function( y )
%the cohesion (theta) function in dynamic function
    alpha = 1.5;
    numerator = 1 - exp( - alpha * y );
    denominator = 1 + exp( - alpha * ( y - 0.5 ));
    theta_y = numerator ./ denominator;

end

