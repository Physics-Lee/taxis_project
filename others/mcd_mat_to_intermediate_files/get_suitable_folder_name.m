function suitable_name = get_suitable_folder_name(full_path)
if contains(full_path,'N2_taxis')
    suitable_name = 'N2_taxis';
elseif contains(full_path,'WEN0216_taxis')
    suitable_name = 'WEN0216_taxis';
elseif contains(full_path,'WEN0216_test_1.7Agar')
    suitable_name = 'WEN0216_test_1.7Agar';
end
end