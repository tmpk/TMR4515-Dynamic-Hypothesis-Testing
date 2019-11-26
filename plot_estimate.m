y = measured_y.Data;
estimated_y = y_hat.Data;
real_y = true_y.Data;
ts = measured_y.Time;
figure;
%sgtitle('Dynamic hypothesis testing')
subplot(2,1,1)
p1 = plot(ts, y(:,1),'-b','LineWidth',0.6); hold on
p2 = plot(ts, real_y(:,1), '-y','LineWidth',0.6)
xlim([0 10])
ylabel('$\theta$ [rad]', 'Interpreter', 'Latex', 'FontSize', 11)
legend([p1 p2],'Measured $\theta_{L1}$', 'True $\theta_{L1}$', 'Interpreter', 'Latex', 'FontSize', 10);
subplot(2,1,2)
p1 = plot(ts, y(:,2),'-b','LineWidth',0.6); hold on
p2 = plot(ts, real_y(:,2), '-y','LineWidth',0.6)
xlim([0 10])
legend([p1 p2],'Measured $\theta_{L2}$', 'True $\theta_{L2}$', 'Interpreter', 'Latex', 'FontSize', 10);
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 11)
ylabel('$\theta$ [rad]', 'Interpreter', 'Latex', 'FontSize', 11)

figure;
subplot(2,1,1)
p1 = plot(ts, estimated_y(:,1),'-b','LineWidth',0.8); hold on
p2 = plot(ts, real_y(:,1),'--r','LineWidth',0.8); hold off
legend([p1, p2],'Estimated $\theta_{L1}$','True $\theta_{L1}$', 'Interpreter', 'latex', 'FontSize', 10);
xlim([0 10])
ylabel('$\theta$ [rad]', 'Interpreter', 'Latex', 'FontSize', 11)
subplot(2,1,2)
p3 = plot(ts, estimated_y(:,2),'-b','LineWidth',0.8); hold on;
p4 = plot(ts, real_y(:,2),'--r','LineWidth',0.8); 
legend([p3, p4],'Estimated $\theta_{L2}$','True $\theta_{L2}$','Interpreter', 'latex', 'FontSize', 10);
xlim([0 10])
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 11)
ylabel('$\theta$ [rad]', 'Interpreter', 'Latex', 'FontSize', 11)
hold off;


