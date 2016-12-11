function [ model ] = generate_strategy( x, nt, model, flag )
%   generate resource distribution strategy at time step nt
%   
    if flag == 2
        if mod(nt, 100) ~= 1
            error('not the right time step to distribute resources !!!')
        end
        nt = (nt - 1) / 100 + 1;
    end

    if nt == 1
%         Rit = zeros(model.Nnode, 1);
%         R_cum_it = Rit;
    else
   
        if strcmp(model.strategy, 'op')
%             Rit = model.Rit(:, nt);
%             R_cum_it = model.R_cum_it(:, nt);
        end

    %     when resources have arrived
        if nt > model.ntD && nt <= model.ntD + (size(model.Rit, 2) - 1) / 2 + 1

    %         uniform dissemination
            if strcmp(model.strategy, 'S1')
                model.Rit(:, nt) = model.Rt(nt) / model.Nnode * ones(model.Nnode, 1);
                model.R_cum_it(:, nt) = model.R_cum_it(:, nt - 1) + model.Rit(:, nt);
            end

    %         out-degree based dissemination
            if strcmp(model.strategy, 'S2')
                for i = 1 : model.Nnode
                    outd(i) = length(find(model.M(i, :)));
                end
                r = outd / sum(outd);
                model.Rit(:, nt) = model.Rt(nt) * r;
                model.R_cum_it(:, nt) = model.R_cum_it(:, nt - 1) + model.Rit(:, nt);
            end

    %         uniform reinforcement of challenged nodes
            if strcmp(model.strategy, 'S3')
                mask = find(x > 0);
                n = length(mask);
                model.Rit(mask, nt) = model.Rt(nt) / n * ones(n, 1);
                model.R_cum_it(:, nt) = model.R_cum_it(:, nt - 1) + model.Rit(:, nt);
            end

    %         simple targeted reinforcement of destroyed nodes
            if strcmp(model.strategy, 'S4')
                if isempty(find(x > model.theta, 1))
%                     disp('fuck')
                    model.Rit(:, nt) = model.Rt(nt) / model.Nnode * ones(model.Nnode, 1);
                    model.R_cum_it(:, nt) = model.R_cum_it(:, nt - 1) + model.Rit(:, nt);
                else
                    n = length(find(x > model.theta));
%                     for i = 1 : model.Nnode
%                         if x(i) > model.theta
%                             model.Rit(i, nt) = model.Rt(nt) / n;
%                         else
%                             model.Rit(i, nt) = 0;
%                         end
%                     end
                    model.Rit(x > model.theta, nt) = model.Rt(nt) / n;
                    model.R_cum_it(:, nt) = model.R_cum_it(:, nt - 1) + model.Rit(:, nt);
                end
                
                if abs(sum(model.Rit(:, nt)) - model.Rt(nt)) > 0.001
                    disp(nt)
                    disp(model.Rt(nt))
                    disp(sum(model.Rit(:, nt)))
                    disp(n)
                end
            end

    %         simple targeted reinforcement of highly connected nodes
            if strcmp(model.strategy, 'S5')
                q = 0.15;
                k = 0.8;
                q = floor(q * length(x));

                [temp, I] = sort(model.outd, 'descend');
                I_high = I(1 : q);
                I_low = I(q + 1 : end);

    %             highly connected nodes
                model.Rit(I_high, nt) = k * model.Rt(nt) / q * ones(q, 1);
    %             rest nodes
                if length(find(x(I_low) > model.theta)) == 0
                    model.Rit(I_low, nt) = (1 - k) * model.Rt(nt) / (model.Nnode - q) * ones(model.Nnode - q, 1);
                else
                    n = length(find(x(I_low) > model.theta));
                    temp = model.Rit(I_low, nt);
                    temp(x(I_low) > model.theta) = (1 - k) * model.Rt(nt) / n;
                    model.Rit(I_low, nt) = temp;
                end

                model.R_cum_it(:, nt) = model.R_cum_it(:, nt - 1) + model.Rit(:, nt);

            end

    %         out-degree based targeted reinforcement of destroyed nodes
            if strcmp(model.strategy, 'S6')
                if length(find(x > model.theta)) == 0
                    model.Rit(:, nt) = model.Rt(nt) / model.Nnode * ones(model.Nnode, 1);
                    model.R_cum_it(:, nt) = model.R_cum_it(:, nt - 1) + model.Rit(:, nt);
                else
                    I = find(x > model.theta);
                    if sum(model.outd(I) > 0)
                        r = model.outd(I) / sum(model.outd(I));
                    else
                        r = 1 / length(I);
                    end

                    model.Rit(:, nt) = zeros(model.Nnode, 1);
                    model.Rit(I, nt) = model.Rt(nt) * r;

                    model.R_cum_it(:, nt) = model.R_cum_it(:, nt - 1) + model.Rit(:, nt);
                end
            end

        elseif nt <= model.ntD

%             Rit = zeros(model.Nt, 1);
%             model.R_cum_it(:, nt) = zeros(model.Nt, 1);

        elseif nt > model.ntD + (size(model.Rit, 2) - 1) / 2 + 1

%             Rit = zeros(model.Nnode, 1);
            model.R_cum_it(:, nt) = model.R_cum_it(:, model.ntD + (size(model.Rit, 2) - 1) / 2 + 1);

        end
    end
    
%

end

