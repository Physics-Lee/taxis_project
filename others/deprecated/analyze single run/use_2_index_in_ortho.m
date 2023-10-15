% calculate chemo-index, thermo-index for ortho
%
% 2023-09-29, Yixuan Li
%

esets = read_ortho_esets;
esets_results = cell(size(esets));
esets_results(:,2) = esets(:,2);

for ii = 1:length(esets)
    
    eset = esets{ii,1}.eset;
    [chemo_index, thermo_index] = chemo_and_thermo_index_of_runs_ortho(eset);    
    esets_results{ii,3} = mean(chemo_index);
    esets_results{ii,4} = mean(thermo_index);
    esets_results{ii,5} = chemo_index';
    esets_results{ii,6} = thermo_index';
    
end