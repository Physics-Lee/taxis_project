function histogram_of_std_of_theta(std_of_theta_all)

figure;
histogram(std_of_theta_all);
xlabel('std of theta');
ylabel('count');
title('f(std of theta)');
hold on;

end