function calculate_the_Ind_max_and_time_max_of_a_track(eset,type_of_C_elegans,type_of_taxis)
count_track = 0;
number_of_experiment = length(eset.expt);
for experiment_number = 1:number_of_experiment
    number_of_track = length(eset.expt(1,experiment_number).track);
    for track_number = 1:number_of_track
        count_track = count_track + 1;
        
        % get the last Ind of the last run
        number_of_run = length(eset.expt(1,experiment_number).track(1,track_number).run);
        if number_of_run >= 1
            t_1 = eset.expt(1,experiment_number).track(1,track_number).run(number_of_run).endInd;
        else
            t_1 = 0;
        end
        
        % get the last Ind of the last reorientation
        number_of_reorientation = length(eset.expt(1,experiment_number).track(1,track_number).reorientation);
        if number_of_reorientation >= 1
            t_2 = eset.expt(1,experiment_number).track(1,track_number).reorientation(number_of_reorientation).endInd;
        else
            t_2 = 0;
        end
        
        % calculate the max Ind
        if t_1 > t_2
            max_Ind = t_1;
        else
            max_Ind = t_2;
        end
        max_Ind_of_this_track(count_track) = max_Ind;
        
        % calculate the ratio and the max time
        ratio_of_this_track = eset.expt(1,experiment_number).track(1,track_number).run(number_of_run).runTime...
            / (eset.expt(1,experiment_number).track(1,track_number).run(number_of_run).endInd...
            - eset.expt(1,experiment_number).track(1,track_number).run(number_of_run).startInd);
        max_time_of_this_track(count_track) = max_Ind * ratio_of_this_track;  
        
    end
end

% plot
figure(1);
plot(max_time_of_this_track,'black-o');
xlabel('track number');
ylabel('max time(s)');
title([type_of_C_elegans ' ' type_of_taxis '; total track number is ' num2str(count_track)]);

figure(2);
plot(max_Ind_of_this_track,'black-o');
xlabel('track number');
ylabel('max Ind');
title([type_of_C_elegans ' ' type_of_taxis '; total track number is ' num2str(count_track)]);