function [ Rt, t ] = generate_basic( N, R_tot, tD, flag )
%This fucntion generate the total resources sequence
%   
    b = 1.6;
    c = 0.22;
    
    if flag == 1
        T = b / c;
        Ts = linspace(0, b/c, N/2 + 1);
        t = (linspace(0, 100, N + 1))';
        dt = t(2) - t(1);
        a = R_tot / (T^b * exp(- c * T));

        Rt = zeros(N + 1, 1);

        for i = 1 : N/2 + 1
            temp(i, 1) = a * Ts(i)^b * exp(- c * Ts(i));
        end

        ntD = floor(tD / dt);
        Rt(ntD + 1 : ntD + 1 + N/2) = temp;

        temp0 = Rt(1);
        for i = 2 + ntD : N/2 + 1 + ntD
            temp1 = Rt(i);
            Rt(i) = Rt(i) - temp0;
            temp0 = temp1;
        end
    end
        
    if flag == 2
        T = b / c;
        Ts = linspace(0, b/c, N/200 + 1);
        t = (linspace(0, 100, N + 1))';
        dt = t(2) - t(1);
        a = R_tot / (T^b * exp(- c * T));

        Rt = zeros(N/100 + 1, 1);

        for i = 1 : N/200 + 1
            temp(i, 1) = a * Ts(i)^b * exp(- c * Ts(i));
        end

        ntD = floor(tD / dt / 100);
        Rt(ntD : ntD + N/200) = temp;

        temp0 = Rt(1);
        for i = 1 + ntD : N/200 + ntD
            temp1 = Rt(i);
            Rt(i) = Rt(i) - temp0;
            temp0 = temp1;
        end
    end
        
end

