% Get taxis info from the folder path.
%
% 2024-01-02, Yixuan Li
%

function title_str = get_title_str(folder_path_to_eset)

if contains(folder_path_to_eset,"NC")
    title_str = "NC";
elseif contains(folder_path_to_eset,"NT")
    title_str = "NT";
elseif contains(folder_path_to_eset,"Or") || contains(folder_path_to_eset,"ortho")
    title_str = "Or";
elseif contains(folder_path_to_eset,"Ctl")
    title_str = "Ctl";
else
    error("No suitable title string!");
end

end