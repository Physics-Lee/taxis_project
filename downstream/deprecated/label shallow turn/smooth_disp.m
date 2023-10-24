function run_displacement = smooth_disp(run_displacement)
for i = 1:length(run_displacement)
    run_displacement{i,1} = my_smooth(run_displacement{i,1});
end
end