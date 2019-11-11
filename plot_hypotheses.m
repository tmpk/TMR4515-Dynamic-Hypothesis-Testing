h1 = hyps.data(:,1);
h2 = hyps.data(:,2);
h3 = hyps.data(:,3);

figure;
sgtitle('Dynamic hypothesis testing')
subplot(3,1,1);
p = plot(hyps.Time, h1,'-b','LineWidth',0.8);

title('$H_1$: $k_2 = 2$, $k_5 = 2$', 'Interpreter', 'latex', 'FontSize', 12)
%legend(p, '$\beta$ actual', '$\hat{\beta}$ estimated', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$p(H_1)$', 'Interpreter', 'latex', 'FontSize', 12)
%xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 12)
grid on
hold off

subplot(3,1,2);
p = plot(hyps.Time, h2, '-b','LineWidth',0.8); hold on


title('$H_2$: $k_1 = 1$, $k_2 = 1.75$', 'Interpreter', 'latex', 'FontSize', 12)
%legend(p, '$\phi$ actual', '$\hat{\phi}$ estimated', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$p(H_2)$', 'Interpreter', 'latex', 'FontSize', 12)
%xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 13)
grid on
hold off

subplot(3,1,3);
p = plot(hyps.Time, h3, '-b','LineWidth',0.8); hold on

title('$H_3$: $k_2 = 2$, $k5 = 1.25$', 'Interpreter', 'latex', 'FontSize', 12)
%legend(p, '$p$ actual with noise', '$p$ actual', '$\hat{p}$ estimated', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$$p(H_3)$', 'Interpreter', 'latex', 'FontSize', 12)
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 12)
grid on
hold off