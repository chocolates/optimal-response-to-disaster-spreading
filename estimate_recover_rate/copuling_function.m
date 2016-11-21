function [ output_value ] = copuling_function( y )
    alpha = 1;
    numerator =  1 - exp(-alpha * y);
    denominator  = 1 + exp(-alpha * (y-0.5));
    output_value = numerator / denominator;

end

