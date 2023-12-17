% create a folder if it doesn't exist.
%
% 2023-10-02, Yixuan Li
%

function create_folder(folder_path)

if ~isfolder(folder_path)
    mkdir(folder_path);
end

end