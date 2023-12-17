function folder = get_folder_name(option_input_data)
    switch option_input_data
        case 1
            folder = 'all';
        case 2
            folder = 'all_first_half_of_a_run';
        case 3
            folder = 'all_second_half_of_a_run';
        case 4
            folder = 'all_first_half_of_an_exp';
        case 5
            folder = 'all_second_half_of_an_exp';
    end
end