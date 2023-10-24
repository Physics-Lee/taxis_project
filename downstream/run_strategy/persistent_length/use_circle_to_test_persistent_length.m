% use a circle to test if the code of persistent length is right.
%
% 2023-09-26, Yixuan Li
%

perimeter = 3; % mm
r = (perimeter/(2*pi))*22;
center = [0,0];
n_cycle = 1;
n_theta_of_one_cycle = 100;
theta = linspace(1/2*pi,1/2*pi + n_cycle*2*pi, n_theta_of_one_cycle*n_cycle);
x = center(1) + r * cos(theta);
y = center(2) + r * sin(theta);
plot(x, y, 'black-o');
axis equal;
run = [x; y];

% create copies
n_copy = 1;
run_displacement = cell(1,1);
for i = 1:n_copy
    run_displacement{i,1} = run;
end

% input data
option_taxis = 3;
mats = input_data(option_taxis);
mats{1, 1}.run_displacement = run_displacement;
mats{1, 2} = 'use a circle to test';