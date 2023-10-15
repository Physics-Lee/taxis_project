function theta_delta_conditioned_by_theta_in(eset,type_of_C_elegans,type_of_taxis)

count_track_after_screen = 0;
count_reorientation = 0;
number_of_experiment = length(eset.expt);
for experiment_number = 1:number_of_experiment
    number_of_track = length(eset.expt(1,experiment_number).track);
    for track_number = 1:number_of_track
        %% screen
        track = eset.expt(1,experiment_number).track(1,track_number);
        flag = screen_a_track(track);
        if flag == 0
            continue;
        end
        count_track_after_screen = count_track_after_screen + 1;       
        
        %% count reorientation
        total_reorientation_number = length(track.reorientation);
        for reorientation_number = 1:total_reorientation_number
            count_reorientation = count_reorientation + 1;
            theta_in(count_reorientation) = track.reorientation(reorientation_number).thetaIn;
            theta_out(count_reorientation) = track.reorientation(reorientation_number).thetaOut;
            theta_delta(count_reorientation) = track.reorientation(reorientation_number).dTheta;
        end
    end
end

folder_name = ['D:\' type_of_C_elegans ' ' type_of_taxis '_frequecy_of_reorientation_versus_theta_unconditional'];
if isfolder(folder_name) == 0
    mkdir(folder_name);
end

for number_of_bin = [2 4 6 8 10 12 14 16 18 20]
    
    edges = [-pi -pi:2*pi/number_of_bin:+pi +pi];% 
    
    histogram(theta_in,edges,'Normalization','probability')
    title([type_of_C_elegans ' ' type_of_taxis ' theta in']);
    saveas(gcf,[folder_name '\' 'theta_in_' 'number_of_bin_' num2str(number_of_bin) '.png']);
    
    histogram(theta_out,edges,'Normalization','probability')
    title([type_of_C_elegans ' ' type_of_taxis ' theta out']);
    saveas(gcf,[folder_name '\' 'theta_out_' 'number_of_bin_' num2str(number_of_bin) '.png']);
    
end

for number_of_bins = 20
    
    % draw
    edges = [-pi -pi:2*pi/number_of_bins:+pi +pi];    
    histogram(theta_delta,edges,'Normalization','probability')
    ylim([0 0.25])
    xlabel('theta delta');
    ylabel('frequency');
    title([type_of_C_elegans ' ' type_of_taxis]);
    
    % save
    saveas(gcf,[folder_name '\' 'number_of_bin_' num2str(number_of_bins) '.png']);
    
end

%% conditional probability
theta_in = theta_in + pi; % from [-pi,+pi] to [0,+2pi]
if contains(type_of_taxis,'NC')
    the_most_wrong_direction = pi;
end
if contains(type_of_taxis,'NT') || contains(type_of_taxis,'Pa')
    the_most_wrong_direction = pi; % NT和Parallel需要改
end
if contains(type_of_taxis,'ortho')
    the_most_wrong_direction = 5/4 * pi;
end
number_of_regions = 4; % 2 4 6 8
part = 2 * pi / ( 2 * number_of_regions );

partition = floor( (theta_in - the_most_wrong_direction) / part );
partition_unique = unique(partition);

% 法一
switch number_of_regions
    case 2
    case 4
        index_of_0 = find(~partition_unique);
        flag_test = false(4,length(theta_delta));
        for i = 1:4
            index(1,i) = my_mod(index_of_0-i,2*number_of_regions);
            index(2,i) = my_mod(index_of_0+(i-1),2*number_of_regions);
            flag_test(i,:) = partition == partition_unique(index(1,i)) | partition == partition_unique(index(2,i));
            histogram_theta_delta(theta_delta(flag_test(i,:)),type_of_C_elegans,type_of_taxis,i);
        end
end


% 法二
% switch number_of_regions
%     case 2
%         theta_delta_1 = theta_delta(theta_in > the_most_wrong_direction-part & theta_in < the_most_wrong_direction+part);        
%         theta_delta_2 = theta_delta(theta_in < the_most_wrong_direction-part | theta_in > the_most_wrong_direction+part);
%         histogram_theta_delta(theta_delta_1,type_of_C_elegans,type_of_taxis,1)
%         histogram_theta_delta(theta_delta_2,type_of_C_elegans,type_of_taxis,2)
%     case 4
%         theta_delta_1 = theta_delta(theta_in > the_most_wrong_direction-part & theta_in < the_most_wrong_direction+part);        
%         theta_delta_2 = theta_delta((theta_in > the_most_wrong_direction-part*2 & theta_in < the_most_wrong_direction-part)|(theta_in > the_most_wrong_direction+part & theta_in < the_most_wrong_direction+part*2));
%         theta_delta_3 = theta_delta((theta_in > the_most_wrong_direction-part*3 & theta_in < the_most_wrong_direction-part*2)|(theta_in > the_most_wrong_direction+part*2 & theta_in < the_most_wrong_direction+part*3));        
%         theta_delta_4 = theta_delta(theta_in > the_most_wrong_direction-part*5 & theta_in < the_most_wrong_direction-part*3);
%         histogram_theta_delta(theta_delta_1,type_of_C_elegans,type_of_taxis,1)
%         histogram_theta_delta(theta_delta_2,type_of_C_elegans,type_of_taxis,2)
%         histogram_theta_delta(theta_delta_3,type_of_C_elegans,type_of_taxis,3)
%         histogram_theta_delta(theta_delta_4,type_of_C_elegans,type_of_taxis,4)
%         flag_test_2(1,:) = theta_in > the_most_wrong_direction-part & theta_in < the_most_wrong_direction+part;  
% end
end