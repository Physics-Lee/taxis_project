% add label and lim and then output figs
%
% 2023-09-27, Yixuan Li
%

function add_label_and_lim(save_folder_path,option_measure,option_partition_region,option_ideal_theta)

xlabel('run length (mm)', 'FontSize', 14);
x_up_limit = 2; % mm
x_down_limit = 0.2; % mm

switch option_measure

    case "cos"
        ylabel('<cos \theta>', 'FontSize', 14);
        xlim([x_down_limit x_up_limit]);
        ylim([0 1]);

    case "MSE"
        ylabel('<MSE>', 'FontSize', 14);
        xlim([x_down_limit x_up_limit]);
        ylim([0 2]);

    case "tortuosity"
        ylabel('<tortuosity>', 'FontSize', 14);
        xlim([x_down_limit x_up_limit]);
        ylim([0.5 1]);

    case "cos_to_ideal"
        ylabel('<cos to the ideal direction>', 'FontSize', 14);
        xlim([x_down_limit 15]);
        ylim([-1 1]);

    case "MSE_to_ideal"
        ylabel('<MSE to the ideal direction>', 'FontSize', 14);
        xlim([x_down_limit 15]);
        ylim([0 8]);

    case "velocity"
        ylabel('<v> (mm/s)', 'FontSize', 14);
        xlim([x_down_limit 5]);
        ylim([0 0.2]);

    case "Iino_curving_rate"
        x_down_limit = 1;
        ylabel('$<\frac{\Delta \theta}{d}>$ (deg/mm)', 'FontSize', 14, 'Interpreter', 'latex');
        ylim([-30 +30]);

    case "Iino_curving_rate_v3"
        x_down_limit = 1;
        ylabel('$<\frac{|\Delta \theta|}{d}>$ (deg/mm)', 'FontSize', 14, 'Interpreter', 'latex');
        ylim([0 +40]);

end

output_figures(save_folder_path,option_measure,option_partition_region,option_ideal_theta,x_up_limit,'fig');
close;
disp('figs saved successfully!');

end