
nettype = 'SF_';
strategy0 = csvread([nettype, 'average_curve_S0.dat']);
timesteps = 1:length(strategy0);
strategy1 = csvread([nettype, 'average_curve_S1.dat']);
strategy2 = csvread([nettype, 'average_curve_S2.dat']);
strategy3 = csvread([nettype, 'average_curve_S3.dat']);
strategy4 = csvread([nettype, 'average_curve_S4.dat']);
strategy5 = csvread([nettype, 'average_curve_S5.dat']);
strategy6 = csvread([nettype, 'average_curve_S6.dat']);
figure;
hold on;
% h0 = plot(timesteps, strategy0, 'ob');
% h1 = plot(timesteps, strategy1,'-or');
% h2 = plot(timesteps, strategy2,'-*g');
% h3 = plot(timesteps, strategy3,'-sb');
% h4 = plot(timesteps, strategy4,'-^y');
% h6 = plot(timesteps, strategy6,'->k');
h0 = plot(timesteps, strategy0, 'LineWidth',2);
h1 = plot(timesteps, strategy1, 'LineWidth',2);
h2 = plot(timesteps, strategy2, 'LineWidth',2);
h3 = plot(timesteps, strategy3, 'LineWidth',2);
h4 = plot(timesteps, strategy4, 'LineWidth',2);
h5 = plot(timesteps, strategy5, 'LineWidth',2);
h6 = plot(timesteps, strategy6, 'LineWidth',2);
legend([h0, h1,h2,h3,h4, h5,h6],'no resource','strategy1','strategy2','strategy3','strategy4', 'strategy5', 'strategy6');
title('SF Network', 'FontSize',18)
xlabel('time horizon','FontSize',16)
ylabel('damaged nodes', 'FontSize',16)

print(gcf,'-dpdf','SF_linear.pdf')