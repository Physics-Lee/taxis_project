% extract run disps (mm) from an eset
%
% 2023-09-26, Yixuan Li
%

function run_disp = extract_run_disp(eset)

run_disp = {};

for i = 1:length(eset.expt)
    for j = 1:length(eset.expt(i).track)
        if screen_a_track(eset.expt(i).track(j))
            for k = 1:length(eset.expt(i).track(j).run)
                if screen_a_run(eset.expt(i).track(j).run(k))
                    start_ind = eset.expt(i).track(j).run(k).startInd;
                    end_ind = eset.expt(i).track(j).run(k).endInd;
                    run_disp{end+1,1} = eset.expt(i).track(j).run(k).track.dq.displacement(:,start_ind:end_ind) / 22; % (mm)
                end
            end
        end
    end
end

end