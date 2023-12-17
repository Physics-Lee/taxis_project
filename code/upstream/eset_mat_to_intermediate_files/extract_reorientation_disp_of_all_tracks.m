% extract reorientation disps (mm) of all tracks from an eset
%
% 2023-11-05, Yixuan Li
%

function reorientation_disp = extract_reorientation_disp_of_all_tracks(eset)

reorientation_disp = {};

for i = 1:length(eset.expt)
    for j = 1:length(eset.expt(i).track)
        if screen_a_track(eset.expt(i).track(j))
            for k = 1:length(eset.expt(i).track(j).reorientation)
                start_ind = eset.expt(i).track(j).reorientation(k).startInd;
                end_ind = eset.expt(i).track(j).reorientation(k).endInd;
                reorientation_disp{end+1,1} = eset.expt(i).track(j).reorientation(k).track.dq.displacement(:,start_ind:end_ind) / 22; % (mm)
            end
        end
    end
end

end