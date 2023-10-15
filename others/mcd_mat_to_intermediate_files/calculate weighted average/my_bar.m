function my_bar(index_table,y_label_str,file_name)

weighted_average = index_table.weighted_average;
weighted_std = index_table.weighted_std;
barHandle = bar(weighted_average);
xlabel('exp');
ylabel(y_label_str);
xticks(1:length(weighted_average));
xticklabels(index_table.full_path);

x = barHandle.XData + barHandle.XOffset;
y = weighted_average;
e = weighted_std;
hold on
errorbar(x, y, e, 'k', 'linestyle', 'none');

folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\weighted average\bar';
file_path = fullfile(folder_path, file_name);
% saveas(gcf,file_path,'png');
% close;

end