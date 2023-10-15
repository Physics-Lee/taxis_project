function frequency_of_reorientation_versus_t(eset,type_of_C_elegans,type_of_taxis)
count_track_after_screen = 0;
count_reorientation = 0;
number_of_experiment = length(eset.expt);
for experiment_number = 1:number_of_experiment
    number_of_track = length(eset.expt(1,experiment_number).track);
    for track_number = 1:number_of_track
        %% screen
        track = eset.expt(1,experiment_number).track(1,track_number);
        flag = screen_a_track(track);
        if flag == 0
            continue;
        end
        count_track_after_screen = count_track_after_screen + 1;
        
        %% ratio
        number_of_run = length(eset.expt(1,experiment_number).track(1,track_number).run);
        ratio_of_this_track = eset.expt(1,experiment_number).track(1,track_number).run(number_of_run).runTime...
            / (eset.expt(1,experiment_number).track(1,track_number).run(number_of_run).endInd...
            - eset.expt(1,experiment_number).track(1,track_number).run(number_of_run).startInd);
        
        %% calculate the frequency of reorientation
        total_reorientation_number = length(track.reorientation);
        for reorientation_number = 1:total_reorientation_number
            count_reorientation = count_reorientation + 1;
            reorientation_start_time(count_reorientation) = track.reorientation(reorientation_number).startInd * ratio_of_this_track;
        end
    end
end

for number_of_bin = 10:10:30
    histogram(reorientation_start_time,number_of_bin)
    xlabel('time(s)');
    ylabel('count');
    title([type_of_C_elegans ' ' type_of_taxis]);
    % save
    folder_name = ['D:\' type_of_C_elegans ' ' type_of_taxis '_frequecy_of_reorientation_versus_t'];
    if isfolder(folder_name) == 0
        mkdir(folder_name);
    end    
    saveas(gcf,[folder_name '\number_of_bin_' num2str(number_of_bin) '.png']);
end

end