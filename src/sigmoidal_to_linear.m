%%
alpha = 20;
theta = 0.5;

x = 0:0.05:6;
y = sigmoid_value(alpha, theta, x);
plot(x, y);
hold on
y2 = 1/6 * x;
plot(x, y2);
% axis([-5,5,-0.5, 1.5]

%%
% max(model.record_state');
% mean(model.record_state')
