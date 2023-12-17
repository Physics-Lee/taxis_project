% use a circle to test if the code of persistent length is right.
%
% 2023-09-26, Yixuan Li
%

% create a run
n_cycle = 10; % super-parameter
n_theta_of_one_cycle = 100; % frames
perimeter = 10; % mm
% v = perimeter / n_theta_of_one_cycle*2; % mm/s
r = perimeter/(2*pi);
center = [0,0];
theta = linspace(1/2*pi,1/2*pi + n_cycle*2*pi, n_theta_of_one_cycle*n_cycle);
x = center(1) + r * cos(theta);
y = center(2) + r * sin(theta);
plot(x, y, 'black-o');
axis equal;
run = [x; y];

% create copies of the above run
n_copy = 10; % super-parameter
run_disp = cell(1,1);
for i = 1:n_copy
    run_disp{i,1} = run;
end