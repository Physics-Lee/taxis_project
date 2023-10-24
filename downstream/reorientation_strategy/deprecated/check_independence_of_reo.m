function [count_0_to_0,count_0_to_1,count_1_to_0,count_1_to_1,count_0,count_1,count_track,count_reo] = check_independence_of_reo(eset)

count_0_to_0 = 0;
count_0_to_1 = 0;
count_1_to_0 = 0;
count_1_to_1 = 0;
count_0 = 0;
count_1 = 0;
count_track = 0;
count_reo = 0;
n_exp = length(eset.expt);
for i = 1:n_exp
    for j = 1:length(eset.expt(i).track)
        
        % screen
        track = eset.expt(i).track(j);
        if ~screen_a_track(track)
            continue;
        end
        
        count_track = count_track + 1;
        
        % extract
        theta_in = [track.reorientation.thetaIn];
        theta_out = [track.reorientation.thetaOut];
        [~,~,~,~,label] = reo_NC_NT(theta_in,theta_out);
        
        % check        
        count_reo = count_reo + length(theta_in);
        count_0 = count_0 + sum(label == 0);
        count_1 = count_1 + sum(label == 1);
        for k = 1:length(label)-1
            if label(k) == 1 && label(k+1) == 1
                count_1_to_1 = count_1_to_1 + 1;
            elseif label(k) == 1 && label(k+1) == 0
                count_1_to_0 = count_1_to_0 + 1;
            elseif label(k) == 0 && label(k+1) == 1
                count_0_to_1 = count_0_to_1 + 1;
            elseif label(k) == 0 && label(k+1) == 0
                count_0_to_0 = count_0_to_0 + 1;
            end
        end
    end
end

end