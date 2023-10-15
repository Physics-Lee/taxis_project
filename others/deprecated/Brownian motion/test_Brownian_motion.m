% load('D:\Public_repository\Worm-Thermo-Chemotaxis\Code\YixuanLi\run strategy\persistent length\data\all\n2_ortho.mat');
n = length(run_displacement);
result_all = cell(n,1);
for i = 1:n
    trajectory = run_displacement{i};
    result_all{i} = calculateDistances(trajectory);
end

[maxPoints, mergedResult] = mergeResults(result_all);

for i = [1 10 20 50 100] % s
    n_frame = 2 * i;
    distances = mergedResult{n_frame + 1, 2};

    % plot
    str = {'pdf', 'probability', 'cdf', '1-cdf', '1-cdf_semilogy', '1-cdf_loglog'};  % Include '1-cdf' option
    for j = 1:6  % Update the loop to include '1-cdf' plot
        figure;
        if j == 4  % Plot '1-cdf'
            [counts, edges] = histcounts(distances, 'Normalization', 'cdf');
            plot(edges(1:end-1), 1 - counts, 'LineWidth', 2);
            ylabel('1 - cdf');            
        elseif j == 5  % Semilogy plot of '1-cdf'
            [counts, edges] = histcounts(distances, 'Normalization', 'cdf');
            semilogy(edges(1:end-1), 1 - counts, 'LineWidth', 2);
            ylabel('1 - cdf');
            ylim([0.05, 0.95]);
        elseif j == 6  % Loglog plot of '1-cdf'
            [counts, edges] = histcounts(distances, 'Normalization', 'cdf');
            loglog(edges(1:end-1), 1 - counts, 'LineWidth', 2);
            ylabel('1 - cdf');
            ylim([0.05, 0.95]);
        else
            histogram(distances, 'Normalization', str{j});
            ylabel(str{j});
        end

        xlabel(['Euclidean distance between each pair with the difference of ' num2str(i) 's']);
        title(['number of pairs: ' num2str(length(distances))]);

        % Save the plot
        filename = sprintf('plot_%ds_between_each_pair_%s.png', i, str{j});
        saveas(gcf, filename);
    end
end

close all;