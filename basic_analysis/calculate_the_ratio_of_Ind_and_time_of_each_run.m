function calculate_the_ratio_of_Ind_and_time_of_each_run(eset,type_of_C_elegans,type_of_taxis)

% calculate
count_track = 0;
count_run = 0;
number_of_experiment = length(eset.expt);
for experiment_number = 1:number_of_experiment
    number_of_track = length(eset.expt(1,experiment_number).track);
    for track_number = 1:number_of_track
        count_track = count_track + 1;
        number_of_run = length(eset.expt(1,experiment_number).track(1,track_number).run);
        for run_number = 1:number_of_run
            count_run = count_run + 1;
            ratio_run(count_run) = (eset.expt(1,experiment_number).track(1,track_number).run(run_number).endInd...
                - eset.expt(1,experiment_number).track(1,track_number).run(run_number).startInd)...
                / eset.expt(1,experiment_number).track(1,track_number).run(run_number).runTime;
        end
    end
end

% plot
plot(ratio_run,'black-o');
xlabel('run number');
ylabel('(run end Ind - run start Ind)/run time');
title([type_of_C_elegans ' ' type_of_taxis '; number of experiment = ' num2str(number_of_experiment) '; number of track = ' num2str(count_track) '; number of run = ' num2str(count_run)]);

end