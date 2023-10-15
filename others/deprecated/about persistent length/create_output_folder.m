function output_folder = create_output_folder(option_taxis,option_measure,...
    option_region)

s = datestr(datetime, 'yyyy-mm-dd HH-MM-SS');
root_folder = fullfile(...
    'D:\data_of_persistent_length',...
    s);

switch option_taxis
    case 1
        root_folder = [root_folder '_NC'];
    case 2
        root_folder = [root_folder '_NT'];
    case 3
        root_folder = [root_folder '_ortho'];
end

root_folder = [root_folder '_' char(option_measure) '_partition' num2str(option_region)];

% for run timescale and exp timescale
% root_folder = [root_folder '_' folder_data];
% root_folder = strrep(root_folder,'_all','');

output_folder = root_folder;

mkdir(root_folder);

end