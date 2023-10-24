% plot the histogram and then save it
%
% the 2nd input can be n_edges or n_bins
%
% scale: linear for x, linear for y
%
% 2023-09-30, Yixuan Li
%

function create_histogram(data, n_edges, x_ticks, xlabel_str, title_str, full_path, y_lim, scale_of_axis)

figure;
histogram(data, n_edges, 'Normalization', 'pdf');
xticks(x_ticks);
xlabel(xlabel_str,'Interpreter','latex');
ylabel('probability density function');
title(title_str,'Interpreter','latex');
ylim(y_lim);
saveas(gcf, full_path);

if nargin == 8
    if scale_of_axis == "semilogy"
    elseif scale_of_axis == "loglog"
    end
end

end