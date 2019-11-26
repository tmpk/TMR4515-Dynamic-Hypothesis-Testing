% script for plotting the error of K
% K_inf is steady-state Kalman gain, found from kalmd

%K = Kgain.data(:,:,1:100:30000); %
time = 0:0.1:4.1;
error = zeros(42,1);
norm_K_inf = norm(K_inf); % 2-norm of L
norm_K = zeros(1,42);
index = 1;
for i = 1:100:4200
    norm_K(index) = norm(Kgain.data(:,:,i));
    error(index) = norm_K_inf - norm_K(index);
    index = index + 1;
end

figure
p1 = plot(time, ones(1,length(time))*norm_K_inf,'-r','LineWidth',0.6); hold on
p2 = plot(time, norm_K, '-b', 'LineWidth',0.6);
title('Convergence of $K$ to $K_{\infty}$', 'Interpreter', 'latex', 'FontSize', 13)
legend([p1, p2],'$\| K_{\infty} \|_2$', '$\| K \|_2$', 'Interpreter', 'latex', 'FontSize', 13);
ylabel('$\|\cdot\|_2$', 'Interpreter', 'latex', 'FontSize', 13)
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 13)
xlim([0 4]);
ylim([0 0.25]);
grid on
hold off
