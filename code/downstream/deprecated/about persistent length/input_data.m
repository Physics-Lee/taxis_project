function [mats,folder] = input_data(option_taxis)

% input data
[mats,folder] = read_all_mats;

% delete unwanted rows
switch option_taxis
    case 1
        str_remain = 'NC';
    case 2
        str_remain = 'NT';
    case 3
        str_remain = 'ortho'; 
    case 4
        str_remain = 'Ctl';
end
mats = delete_rows(mats,str_remain);

% for only one group
% mats = delete_rows(mats,'n2');
% mats = delete_rows(mats,'ria-chr2(quint)');

% % for n2 and control
% mats_1 = delete_rows(mats,'n2');
% mats_2 = delete_rows(mats,'control');
% mats = [mats_1; mats_2];

end