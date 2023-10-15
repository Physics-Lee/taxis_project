folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\bar';
file_name = 'index';
file_path = fullfile(folder_path, file_name);

bar(index_weighted_average);
xlabel('exp');
ylabel('index');
xticks(1:9);
xticklabels({'N2 Ctl','N2 NC','N2 NT','N2 Or'...
    'RIA Ctl','RIA NC','RIA NT','RIA Or'...
    'RIA NT 1.7'});
saveas(gcf,file_path,'png');