function [ theta_y ] = Theta_function( y, model)
%the cohesion (theta) function in dynamic function
%     if y>0.5
%         fid = fopen('value_in_theta_func.txt', 'a');
%         fprintf(fid, '%d\n', y);
%         fclose(fid);
%     end
        
        
    alpha = model.alpha;
    numerator = 1 - exp( - alpha * y );
    denominator = 1 + exp( - alpha * ( y - 0.5 ));
    theta_y = numerator ./ denominator;
    
%     theta_y = 0.25 * y;
    
end

