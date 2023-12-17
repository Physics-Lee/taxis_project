function esets = read_ortho_esets

    folder = 'C:\Users\11097\Nutstore\1\Worm-Thermo-Chemotaxis\Data\行为学数据整理';
    files_1 = dir(fullfile(folder, '*/ortho/*/eset.mat'));
    files_2 = dir(fullfile(folder, 'n2/ortho/eset.mat'));
    files = [files_1; files_2];
    len = length(files);
    esets = cell(len,2);
    for i = 1:len
        file_name = fullfile(files(i).folder,files(i).name);
        esets{i,1} = load(file_name);
        esets{i,2} = strrep(files(i).folder, folder, '');
    end
    
end    