function theta_ideal = get_ideal_theta_by_taxis_type(option_taxis)

if contains(option_taxis,'NC_Runhui')
    theta_ideal = -1/2*pi;
elseif contains(option_taxis,'NC')
    theta_ideal = +pi;
elseif contains(option_taxis,'NT')
    theta_ideal = +pi;
elseif contains(option_taxis,'Or') || contains(full_path,'ortho')
    theta_ideal = -3/4*pi;
elseif contains(option_taxis,'Ctl') || contains(full_path,'ctl')
    theta_ideal = +pi;
elseif contains(option_taxis,'Pa') % Parallel
    theta_ideal = +pi;
else
    error("No suitable theta_ideal.");
end

end