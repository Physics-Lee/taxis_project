function reorientation_times = extract_reorientation_time(eset)

    reorientation_times = [];

    for i = 1:length(eset.expt)
        for j = 1:length(eset.expt(i).track)
            
            % screen track
            if ~screen_a_track(eset.expt(i).track(j))
                continue;
            end

            % extract reorientation times
            for k = 1:length(eset.expt(i).track(j).reorientation)
                reorientation_times(end+1) = (eset.expt(i).track(j).reorientation(k).endInd - eset.expt(i).track(j).reorientation(k).startInd + 1)/2;
            end
            
        end
    end
    
end