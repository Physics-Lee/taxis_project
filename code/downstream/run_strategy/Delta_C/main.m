% para
ideal_theta = -1/2*pi;

% plot
figure;
subplot(2,1,1)
plot(theta - ideal_theta);
xlabel("frame")
ylabel("$\theta - \theta_{ideal}$","Interpreter","latex")
subplot(2,1,2)
plot(cos(theta - ideal_theta));
xlabel("frame")
ylabel("$cos(\theta - \theta_{ideal})$","Interpreter","latex")

% plot (without reorientation)
