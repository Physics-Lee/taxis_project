function [theta_in,theta_out,theta_delta,length_theta] = extract_theta_first_half(eset)
    n_exp = length(eset.expt);
    theta_in = []; % initialize theta_in as an empty vector
    theta_out = [];
    theta_delta = [];
    for i = 1:n_exp
        
        % get start frame and end frame of an exp
        start_frame_of_an_exp = min([eset.expt(i).track.startFrame]);
        end_frame_of_an_exp = max([eset.expt(i).track.endFrame]);
        half_ind = (start_frame_of_an_exp + end_frame_of_an_exp)/2;            
            
        for j = 1:length(eset.expt(i).track)     
            
            % screen
            track = eset.expt(i).track(j);
            if ~screen_a_track(track)
                continue;
            end
            
            % extract
            for k = 1:length(track.reorientation)                
                if track.reorientation(1,k).startInd + track.startFrame < half_ind
                    theta_in(end+1) = track.reorientation(1,k).thetaIn; % append extracted value to theta_in
                    theta_out(end+1) = track.reorientation(1,k).thetaOut;
                    theta_delta(end+1) = track.reorientation(1,k).dTheta;
                end
            end
            
        end
    end
    length_theta = length(theta_in);
end