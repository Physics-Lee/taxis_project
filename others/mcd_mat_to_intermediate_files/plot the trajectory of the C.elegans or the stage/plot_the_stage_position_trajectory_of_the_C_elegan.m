function plot_the_stage_position_trajectory_of_the_C_elegan(mcd,start_frame,end_frame,fps,save_folder_path)

unit2um = 0.05;
s2frame = 66;
count = 0;

frame_range = start_frame:round(s2frame/fps):end_frame;
stage_positions = [mcd(frame_range).StagePosition];
x = unit2um / 10^3 * stage_positions(1:2:end);
y = unit2um / 10^3 * stage_positions(2:2:end);

% eliminate nan
x = x(~isnan(x));
y = y(~isnan(y));

% plot
circle_size = 10;
scatter(x,y,circle_size,'black');
hold on;
scatter(x(1),y(1),circle_size,'magenta');
scatter(x(end),y(end),circle_size,'cyan');
axis equal
xlabel('x(mm)');
ylabel('y(mm)');
title(['fps = ' num2str(fps) 'Hz']);
legend('trajectory','start','end');

file_name = ['fps_' num2str(fps)];
file_path = fullfile(save_folder_path,file_name);
saveas(gcf,file_path,'png');

close;

end