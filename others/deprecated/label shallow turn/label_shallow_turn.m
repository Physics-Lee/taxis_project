function label = label_shallow_turn(run_disp, frame_window, std_threshold)
   
    if nargin < 2
        frame_window = 10;
    end
    
    if nargin < 3
        std_threshold = 15/180*pi;
    end
    
    run_disp = run_disp/22;
    n_frames = size(run_disp, 2);
    theta = from_points_to_theta(run_disp);
    theta = unwrap(theta);
    label = zeros(n_frames,1);
    
    for i = 1:n_frames - 1 - frame_window
        start_idx = i;
        end_idx = i + frame_window;
        std_now = std(theta(start_idx:end_idx));        
        if std_now > std_threshold
            label(start_idx:end_idx) = 1;
        end
    end
    
end