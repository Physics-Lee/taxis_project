function visualize_a_track_v2(eset)
    n_exp = length(eset.expt);
    for i = 1:n_exp
        number_of_track = length(eset.expt(1,i).track);
        for j = 1:number_of_track            

            % screen
            flag = screen_a_track(eset.expt(1,i).track(1,j));
            if flag == 0
                continue;
            end

            % plot
            trajectory = eset.expt(1,i).track(1,j).dq.displacement;
            x = trajectory(1,:);
            y = trajectory(2,:);
            bool_vec = eset.expt(1,i).track(1,j).isrun;
            scatter(x(bool_vec), y(bool_vec), 'b');
            hold on;
            scatter(x(~bool_vec), y(~bool_vec), 'r');
            xlabel('x');
            ylabel('y');

        end
    end
end
