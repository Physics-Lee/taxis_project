% plot the histogram and then save it
%
% the 2nd input can be n_edges or n_bins
%
% scale: linear for x, linear for y
%
% 2023-09-30, Yixuan Li
%

function create_histogram(data, n_edges, x_ticks, xlabel_str, title_str, full_path, y_lim, save_histcount)

figure;
% data = mod(data + 90,360);
histogram(data, n_edges, 'Normalization', 'pdf');
xticks(x_ticks);
xlabel(xlabel_str,'Interpreter','latex');
ylabel('probability density function');
title(title_str,'Interpreter','latex');
ylim(y_lim);
saveas(gcf, full_path);

if nargin == 8
    if save_histcount
        histcount = histcounts(data, n_edges, 'Normalization', 'pdf');
        folder_path = fileparts(full_path);
        full_path_new = fullfile(folder_path,"histcount_of_theta_pdf.mat");
        save(full_path_new,"histcount");
    end
end

end