function my_scatter(run_displacement,label,my_start,my_end)
run_disp_all = cell_to_mat(run_displacement(my_start:my_end));
label_all = cell_to_mat(label(my_start:my_end));
label_all = logical(label_all);
x = run_disp_all(1,:);
y = run_disp_all(2,:);
figure;
scatter(x(label_all), y(label_all), 'm'); % shallow turn
hold on;
scatter(x(~label_all), y(~label_all), 'b'); % forward
xlabel('x (mm)');
ylabel('y (mm)');
axis equal;
end