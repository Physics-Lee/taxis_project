% Let the user choose the directory containing MP4 files
path = uigetdir;

if path ~= 0
    % Get all MP4 files in the selected directory
    list_mp4 = get_all_files_of_a_certain_type_in_a_rootpath(path, '*.mp4');
    
    % Let the user choose the MP4 files to process
    [indx, tf] = listdlg('ListString', list_mp4, 'ListSize', [800, 600], 'Name', 'Choose MP4 files');
    
    if tf == 1
        for i = indx
            % Get the path of the MP4 file
            full_path = list_mp4{i};
            
            % Read the MP4 file
            video_obj = VideoReader(full_path);
            
            % Create a folder to save images, using the MP4 file's directory
            [folder_path, file_name] = fileparts(full_path);
            save_folder_path = fullfile(folder_path, file_name);
            create_folder(save_folder_path);
            
            frame_number = 0;
            
            while hasFrame(video_obj)
                frame = readFrame(video_obj);
                frame_number = frame_number + 1;
                
                % Generate a filename; you can customize the naming rule
                output_file_name = sprintf('frame_%04d.jpg', frame_number);
                
                % Save the current frame as a JPG image file
                imwrite(frame, fullfile(save_folder_path, output_file_name));
            end
            
            fprintf('Total frames saved for %s: %d\n', list_mp4{i}, frame_number);
        end
    end
end