function all_disp_of_all_tracks = extract_all_disp_of_each_track(eset)

% init
all_disp_of_all_tracks = {};

% loop to get run disp of all tracks
for i = 1:length(eset.expt)
    for j = 1:length(eset.expt(i).track)
        if screen_a_track(eset.expt(i).track(j))

            all_disp_of_a_track = cell(1,1);
            all_disp_of_a_track{1} = eset.expt(i).track(j).dq.displacement / 22; % (mm)
            all_disp_of_all_tracks{end+1,1} = all_disp_of_a_track;

        end
    end
end

end