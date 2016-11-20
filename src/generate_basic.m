function [ Rt ] = generate_basic( R_total, TimeSteps )
% generate resources flow in the system at each time step
ResourceTime = TimeSteps / 2;
Rt = zeros(1, ResourceTime);

a1 = 530;
b1 = 1.6;
c1 = 0.22;

t_maxima = b1 / c1;
unnormalized_r_maxima = a1 * t_maxima ^ b1 * exp(-c1*t_maxima);

resource_scale_factor = R_total / unnormalized_r_maxima;

for tStep=1:ResourceTime
    time_1 = tStep / ResourceTime;
    time_0 = (tStep-1) / ResourceTime;
    time_1_curve = time_1 * t_maxima;
    time_0_curve = time_0 * t_maxima;
    R_1 = resource_scale_factor * a1 * time_1_curve^b1 * exp(-c1 * time_1_curve);
    R_0 = resource_scale_factor * a1 * time_0_curve^b1 * exp(-c1 * time_0_curve);
    Rt(tStep) = R_1 - R_0;
end

end

