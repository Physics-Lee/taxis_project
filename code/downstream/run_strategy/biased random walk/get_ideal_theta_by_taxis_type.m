function theta_ideal = get_ideal_theta_by_taxis_type(option_taxis)

if contains(option_taxis,'NC')
    theta_ideal = +pi;
elseif contains(option_taxis,'NT')
    theta_ideal = +pi;
elseif contains(option_taxis,'Or')
    theta_ideal = -3/4*pi;
elseif contains(option_taxis,'Ctl')
    theta_ideal = +pi;
elseif contains(option_taxis,'Pa') % Parallel
    theta_ideal = +pi;
else
    error("No suitable theta_ideal.");
end

end