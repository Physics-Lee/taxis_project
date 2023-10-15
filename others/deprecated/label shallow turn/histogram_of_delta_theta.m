function histogram_of_delta_theta(delta_theta_all)

figure;
histogram(delta_theta_all);
xlabel('delta theta');
ylabel('count');
title('f(delta of theta)');
hold on;

end