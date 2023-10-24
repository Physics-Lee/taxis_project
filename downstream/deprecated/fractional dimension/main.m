load('F:\1_learning\research\taxis of C.elegans\high throughout system\data\n2\ortho\eset.mat');
D = [];
for expt = eset.expt
    for track = expt.track
        if screen_a_track(track)
            trajectory = track.dq.displacement;
            D(end + 1) = boxCountingDim(trajectory);
        end
    end
end

% more readable
D = -D;

% basic statistics
fprintf('mean of D: %.2f \n',mean(D));
fprintf('std of D: %.2f \n',std(D));
histogram(D);

% visulize a single trajectory
visualizeBoxesWithTrajectory(trajectory, 1);