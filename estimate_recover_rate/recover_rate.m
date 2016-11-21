function [ value ] = recover_rate( R )
    tau_start  = 4;
    beta2 = 0.2;
    alpha2 = 0.58;
    denominator = (tau_start - beta2) * exp(- alpha2 * R) + beta2;
    value = 1 / denominator;

end

