function plot_the_trajectory_of_the_C_elegan_in_the_absolute_frame(mcd,start_frame,end_frame,fps,folder_path)

global pixel2um unit2um
pixel2um = 1.6835;
unit2um = 0.05;
s2frame = 66;

% calculate the mean of start_segment to end_segment as the center of mass
start_segment = 40;
end_segment = 60;

% calculate the center of mass
count = 0;
for i = start_frame:round(s2frame/fps):end_frame

    count = count + 1;
    centerline = convert_coordinates_and_add_stage_position(mcd(i).SegmentedCenterline, mcd(i).StagePosition);
    x(count) = mean(centerline(1,start_segment:end_segment));
    y(count) = mean(centerline(2,start_segment:end_segment));

end

% eliminate nan
x = x(~isnan(x));
y = y(~isnan(y));

% plot
figure;
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
file_path = fullfile(folder_path,file_name);
saveas(gcf,file_path,'fig');
saveas(gcf,file_path,'png');

close;

end