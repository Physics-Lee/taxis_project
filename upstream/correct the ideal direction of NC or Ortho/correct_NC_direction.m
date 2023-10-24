% Flip x and y for NC
%
% 2023-10-24, Yixuan Li
%

function run_disp_corrected = correct_NC_direction(run_disp)

n = length(run_disp);
run_disp_corrected = cell(n,1);
for i = 1:n
    run_disp_now = run_disp{i};
    run_disp_now(1,:) = - run_disp_now(1,:); % x
    run_disp_now(2,:) = - run_disp_now(2,:); % y
    run_disp_corrected{i} = run_disp_now;
end

end