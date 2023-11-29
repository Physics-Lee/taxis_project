theta_now = theta_cell_filted_unwrapped{29,1};
theta_now = rad2deg(theta_now);
n_theta = length(theta_now);
max_frame = 40;
theta_t1 = theta_now(1:n_theta-max_frame);
theta_t2 = theta_now(1+max_frame:n_theta);

% figure;
% hold on;
% plot(1:length(theta_t1),theta_t1,'r-o');
% plot(1:length(theta_t1),theta_t2,'b-o');
% xlabel('frame');
% ylabel('deg');
% legend('t','t+tau');

figure;
plot(theta_t1,theta_t2,'k-o');
xlabel('theta(t)');
ylabel('theta(t+tau)');

r = corrcoef(theta_t1,theta_t2)