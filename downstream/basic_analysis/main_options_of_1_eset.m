clc;clear;close all;
while 1       
    print_menu;
    option = input("Which option do you want to conduct?\n");
    switch option
        case 0
            [eset,type_of_C_elegans,type_of_taxis] = upload_eset;
        case 1
            calculate_the_ratio_of_Ind_and_time_of_each_run(eset,type_of_C_elegans,type_of_taxis);
        case 2
            calculate_the_Ind_max_and_time_max_of_a_track(eset,type_of_C_elegans,type_of_taxis);
        case 3
            visualize_a_track(eset,type_of_C_elegans,type_of_taxis);
        case 4
            count_expt_track_run_reorientation(eset);
        case 5
            average_speed_of_a_track = v_versus_t(eset);
        case 7
            frequency_of_reorientation_versus_t(eset,type_of_C_elegans,type_of_taxis);
        case 10
            theta_delta_conditioned_by_theta_in(eset,type_of_C_elegans,type_of_taxis);
        case 100
            break;
        otherwise
            error("Invalid option selected.");
    end
    pause(0.5);
end