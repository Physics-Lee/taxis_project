function visualize_a_track(eset, type_of_C_elegans, type_of_taxis)
    count_track_after_screen = 0;
    number_of_exp = length(eset.expt);
    
    xlabel('time');
    ylabel('trial number');
    title([type_of_C_elegans ' ' type_of_taxis]);
    
    for exp_number = 1:number_of_exp
        
        number_of_track = length(eset.expt(1,exp_number).track);
        
        for track_number = 1:number_of_track
            
            % screen
            track = eset.expt(1,exp_number).track(1,track_number);
            flag = screen_a_track(track);
            if flag == 0
                continue;
            end
            count_track_after_screen = count_track_after_screen + 1;

            % run
            run_Ind = [track.run.startInd; track.run.endInd];            
            ratio_of_this_track = track.run(end).runTime / (track.run(end).endInd - track.run(end).startInd);
            run_time = run_Ind * ratio_of_this_track;

            % plot
            trial_number = count_track_after_screen * ones(2,length(track.run));
            plot(run_time, trial_number, 'blue');
            hold on;

            % reorientation
            reorientation_Ind = [track.reorientation.startInd; track.reorientation.endInd];
            reorientation_time = reorientation_Ind * ratio_of_this_track;

            % plot
            trial_number = count_track_after_screen * ones(2,length(track.reorientation));       
            plot(reorientation_time, trial_number, 'red');
        end
    end
end
