%%
alpha = 0.8;
theta = 0.5;

x = 0:0.05:6;
y = sigmoid_value(alpha, theta, x);
plot(x, y);
hold on
% plot(x, x);
% axis([-5,5,-0.5, 1.5])

%%
% max(model.record_state');
% mean(model.record_state')
