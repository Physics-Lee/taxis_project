function [theta_in,theta_out,theta_delta,length_theta] = extract_theta(eset)
    n_exp = length(eset.expt);
    n_reorientation = 0;
    theta_in = zeros(1, n_reorientation);
    theta_out = zeros(1, n_reorientation);
    theta_delta = zeros(1, n_reorientation);
    for i = 1:n_exp
        for j = 1:length(eset.expt(i).track)
                        
            track = eset.expt(i).track(j);
            
            % screen
            if ~screen_a_track(track)
                continue;
            end
            
            % extract
            n_reorientation_new = length(track.reorientation);
            n_reorientation = n_reorientation + n_reorientation_new;        
            theta_in(n_reorientation-n_reorientation_new+1:n_reorientation) = [track.reorientation.thetaIn];
            theta_out(n_reorientation-n_reorientation_new+1:n_reorientation) = [track.reorientation.thetaOut];
            theta_delta(n_reorientation-n_reorientation_new+1:n_reorientation) = [track.reorientation.dTheta];
            
        end
    end
    length_theta = length(theta_in);
end