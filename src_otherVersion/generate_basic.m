function [ Rt ] = generate_basic( model )
% generate resources flow in the system at each time step
    ResourceTimeStep = model.TimeStep / 2;
    Rt = zeros(1, ResourceTimeStep);

    a1 = 530;
    b1 = 1.6;
    c1 = 0.22;

    t_maxima = b1 / c1;
    unnormalized_r_maxima = a1 * (t_maxima ^ b1) * exp( -c1 * t_maxima );
    resource_scale_factor = model.R_tot / unnormalized_r_maxima;

    R_cumulative = zeros(1, ResourceTimeStep+1);
    for tStep = 1:ResourceTimeStep
         time_ratio = tStep / ResourceTimeStep;
         time_on_curve = time_ratio * t_maxima;
         R_cumulative(tStep + 1) = resource_scale_factor * a1 * (time_on_curve ^ b1) * exp(-c1 * time_on_curve);
         Rt(tStep) = R_cumulative(tStep+1) - R_cumulative(tStep);
    end

end
