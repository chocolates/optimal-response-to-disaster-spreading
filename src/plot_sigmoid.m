alphas = [1, 5, 10, 20];

theta = 0.5;
n = length(alphas);
x = 0 : 0.01 : 1.5;

figure
for i = 1 : n
    alpha = alphas(i);
    y = (1 - exp(-alpha * x)) ./ (1 + exp(-alpha * (x - theta)));
    plot(x, y, 'LineWidth', 1.5); hold on
    xlabel('x')
    ylabel('\Theta(x)');
    title('Sigmoid function w.r.t. different \alpha')
end

legend('\alpha = 1', '\alpha = 5', '\alpha = 10', '\alpha = 20')