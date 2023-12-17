% plot the histogram of delta theta between certain frames
%
% 2023-09-30, Yixuan Li
%

function option_taxis = get_taxis_type_by_full_path(full_path)

if contains(full_path,'NC')
    option_taxis = "NC";
elseif contains(full_path,'NT')
    option_taxis = "NT";
elseif contains(full_path,'Or') || contains(full_path,'ortho')
    option_taxis = "Or";
elseif contains(full_path,'Ctl') || contains(full_path,'ctl')
    option_taxis = "Ctl";
elseif contains(full_path,'Pa') % Parallel
    option_taxis = "Pa";
else
    error("No suitable taxis type.");
end

end