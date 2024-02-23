function theta_ideal = get_ideal_theta(full_path_of_eset)

option_taxis = get_taxis_type_by_full_path(full_path_of_eset);
theta_ideal = get_ideal_theta_by_taxis_type(option_taxis);

end