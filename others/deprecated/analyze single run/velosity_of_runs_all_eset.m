% esets = read_all_eset;
for i = 1:length(esets)
    eset = esets{i,1}.eset;
    velosity = velosity_of_runs_second_half_of_an_exp(eset);
    esets{i,3} = mean(velosity);
    esets{i,4} = velosity';
end