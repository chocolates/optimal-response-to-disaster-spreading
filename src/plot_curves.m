
    
strategy0 = csvread('average_curve_S0.dat');
timesteps = 1:length(strategy0);
strategy1 = csvread('average_curve_S1.dat');
strategy2 = csvread('average_curve_S2.dat');
strategy3 = csvread('average_curve_S3.dat');
strategy4 = csvread('average_curve_S4.dat');
strategy6 = csvread('average_curve_S6.dat');
figure;
hold on;
% h0 = plot(timesteps, strategy0, 'ob');
% h1 = plot(timesteps, strategy1,'-or');
% h2 = plot(timesteps, strategy2,'-*g');
% h3 = plot(timesteps, strategy3,'-sb');
% h4 = plot(timesteps, strategy4,'-^y');
% h6 = plot(timesteps, strategy6,'->k');
h0 = plot(timesteps, strategy0);
h1 = plot(timesteps, strategy1);
h2 = plot(timesteps, strategy2);
h3 = plot(timesteps, strategy3);
h4 = plot(timesteps, strategy4);
h6 = plot(timesteps, strategy6);
legend([h0, h1,h2,h3,h4,h6],'strategy0','strategy1','strategy2','strategy3','strategy4', 'strategy6');
title('Grid Network', 'FontSize',18)
xlabel('time horizon','FontSize',16)
ylabel('damaged nodes', 'FontSize',16)

