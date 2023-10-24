function process_Colbert_data()
    const = getConstants();
    path = uigetdir(const.defaultPath);
    if path ~= 0
        list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path, const.fileType);
        [indx, tf] = listdlg('ListString', list, 'ListSize', const.listSize, 'Name', 'Choose files to convert');
        if tf == 1
            processFiles(list, indx);
        end
    end
end

function const = getConstants()
    % get some constants for further analysis
    const = struct();
    const.defaultPath = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\run_disp_smoothed_downsampled_smoothed';
    const.fileType = '*.mat';
    const.listSize = [800, 600];
end

function processFiles(list, indx)
    for i = indx

        % load
        full_path = list{i};
        run_disp_all = load_struct(full_path);

        % region partition
        file_name = getFileName(full_path);
        option_region = getOptionRegion(file_name);

        % using the same format as high-throughout system
        mats = createMats(run_disp_all, file_name);

        % ortho option
        option_measure = 'cos';
        option_ideal_direction = 1; % -180, -135, -90 (this option is deprecated temporarily)

        % create save folder
        output_folder = determineOutputFolder(full_path);
        createFolderIfNeeded(output_folder);

        % calculate persistent length
        persistent_length(mats, option_measure, option_region, option_ideal_direction, output_folder);
    end
end

function fileName = getFileName(full_path)
    [~, fileName, ~] = fileparts(full_path);
end

function option_region = getOptionRegion(file_name)
    if contains(file_name, "Ctl") || contains(file_name, "Or")
        option_region = 1;
    elseif contains(file_name, "NC")
        option_region = 3;
    elseif contains(file_name, "NT")
        option_region = 2;
    end
end

function mats = createMats(run_disp_all, file_name)
    temp.run_displacement = run_disp_all;
    mats = {temp, file_name};
end

function output_folder = determineOutputFolder(full_path)
    base_output_folder = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\persistent length (0.2-2mm)\';
    if contains(full_path, 'N2')
        output_folder = [base_output_folder, 'N2'];
    elseif contains(full_path, 'WEN0216_test_1.7Agar')
        output_folder = [base_output_folder, 'RIA_1.7Agar'];
    elseif contains(full_path, 'WEN0216')
        output_folder = [base_output_folder, 'RIA'];
    end
end

function createFolderIfNeeded(output_folder)
    if ~isfolder(output_folder)
        mkdir(output_folder)
    end
end