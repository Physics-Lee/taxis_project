% get disp(mm) in the absolute reference frame。
%
% start_frame, end_frame are n*1 array
%
% 2023-11-05, Yixuan Li
%

function run_disp = get_disp(mcd,start_frame,end_frame)

global pixel2um unit2um
pixel2um = 1.6835;
unit2um = 0.05;

% calculate the mean of start_segment to end_segment as the center of mass
part_extracted = "head";
switch part_extracted
    case "body"
        start_segment = 40;
        end_segment = 60;
    case "head"
        start_segment = 1;
        end_segment = 15;
end

n = length(start_frame);
run_disp = cell(n,1);

for i = 1:n

    % Create array of frames using vectorized code
    frames = start_frame(i):1:end_frame(i);

    % Initialize arrays
    x = nan(1, length(frames));
    y = nan(1, length(frames));

    % Loop over frames
    for j = 1:length(frames)

        centerline = convert_coordinates_and_add_stage_position(mcd(frames(j)).SegmentedCenterline, mcd(frames(j)).StagePosition);
        x(j) = mean(centerline(1,start_segment:end_segment));
        y(j) = mean(centerline(2,start_segment:end_segment));

    end

    % store
    have_nan = true;
    if have_nan
        run_disp{i,1} = [x; y];
    else 
        run_disp{i,1} = [x(~isnan(x)); y(~isnan(y))];
    end

end

end