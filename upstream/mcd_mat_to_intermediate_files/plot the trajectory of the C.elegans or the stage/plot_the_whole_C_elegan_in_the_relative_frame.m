function plot_the_whole_C_elegan_in_the_relative_frame(mcd,start_frame,end_frame,folder_path)

global pixel2um unit2um
pixel2um = 1.6835;
unit2um = 0.05;
count = 0;

for i = start_frame:end_frame
    count = count + 1;
    
    centerline = get_coordinates_in_the_video(mcd(i).SegmentedCenterline);
    boundary_A = get_coordinates_in_the_video(mcd(i).BoundaryA);
    boundary_B = get_coordinates_in_the_video(mcd(i).BoundaryB);
    
    figure(count);
    scatter(centerline(1,:),centerline(2,:),'black');
    axis equal
    hold on
    scatter(boundary_A(1,:),boundary_A(2,:),'red');
    scatter(boundary_B(1,:),boundary_B(2,:),'blue');
    xlabel('x(pixel)');
    ylabel('y(pixel)');
    title('the C.elegan within the video');
    legend('centerline','boundary A','boundary B');
    
    file_name = ['frame_' num2str(i)];
    file_path = fullfile(folder_path,file_name);
%     saveas(gcf,file_path,'fig');
    saveas(gcf,file_path,'png');
    
    close;
end

end