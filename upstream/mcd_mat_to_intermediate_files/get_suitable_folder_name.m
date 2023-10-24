function suitable_name = get_suitable_folder_name(full_path)

if contains(full_path,'N2_taxis') || contains(full_path,'N2')
    suitable_name = 'N2_taxis';
elseif contains(full_path,'WEN0216_taxis') || contains(full_path,'RIA')
    suitable_name = 'WEN0216_taxis';
elseif contains(full_path,'WEN0216_test_1.7Agar') || contains(full_path,'RIA_1.7Agar')
    suitable_name = 'WEN0216_test_1.7Agar';
end

end