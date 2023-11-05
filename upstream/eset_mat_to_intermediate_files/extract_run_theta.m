function run_theta = extract_run_theta(eset)

run_theta = cell(1,1);
count = 0;

for i = 1:length(eset.expt)
    for j = 1:length(eset.expt(i).track)
        if screen_a_track(eset.expt(i).track(j))
            for k = 1:length(eset.expt(i).track(j).run)
                if screen_a_run(eset.expt(i).track(j).run(k))
                    count = count + 1;
                    start_ind = eset.expt(i).track(j).run(k).startInd;
                    end_ind = eset.expt(i).track(j).run(k).endInd;
                    run_theta{count,1} = eset.expt(i).track(j).run(k).track.dq.theta(start_ind:end_ind);
                end
            end
        end
    end
end

end