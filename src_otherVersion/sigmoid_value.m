function [ y_value ] = sigmoid_value( alpha, theta, x_value )
%compute the sigmoid function value
    numerator = 1 - exp( - alpha * x_value );
    denominator = 1 + exp( - alpha * ( x_value - theta ) );
    y_value = numerator ./ denominator;

end

