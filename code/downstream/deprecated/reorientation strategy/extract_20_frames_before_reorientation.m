function X = extract_20_frames_before_reorientation(eset)

    n_exp = length(eset.expt);
    [~,~,~,length_theta] = extract_theta(eset);
    X = zeros(length_theta,20);
    count = 0;
    
    for i = 1:n_exp
        for j = 1:length(eset.expt(i).track)
            
            % screen
            track = eset.expt(i).track(j);
            if ~screen_a_track(track)
                continue;
            end
            
            % extract
            for k = 1:length(track.reorientation)
                count = count + 1;
                start_ind = track.reorientation(k).startInd;
                if start_ind <= 20
                    why;
                else
                    X(count,:) = track.dq.theta(start_ind - 20:start_ind - 1);
                end                
            end
            
        end
    end
    
end