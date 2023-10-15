function theta_delta_conditioned_by_theta_in_v2(eset,eset_info)

[theta_in,~,theta_delta,~] = extract_theta(eset);

root_folder = 'D:\Public_repository\Worm-Thermo-Chemotaxis\Code\YixuanLi\result\reorientation strategy\biased reorientation\';
folder_name = fullfile(root_folder,eset_info);
if isfolder(folder_name) == 0
    mkdir(folder_name);
end

% unconditional frequency
xlabel_str = '$\Delta \theta$';
histogram_for_theta(theta_delta, xlabel_str, eset_info);

% save
file_name = 'theta delta';
full_path = fullfile(folder_name,file_name);
saveas(gcf,full_path,'png');

% conditional frequency
theta_delta_conditioned = partition(eset_info,theta_delta,theta_in);

for i = 1:4
    histogram_for_theta(theta_delta_conditioned{i}, xlabel_str, eset_info);
    file_name = ['theta delta in region ' num2str(i)];
    full_path = fullfile(folder_name,file_name);
    saveas(gcf,full_path,'png');
end

close all;

end

function theta_delta_conditioned = partition(eset_info,theta_delta,theta_in)

theta_delta_conditioned = cell(4,1);

if contains(eset_info,"NC") || contains(eset_info,"NT") || contains(eset_info,"Pa")
    theta_delta_conditioned{1} = theta_delta(theta_in > -1/4*pi & theta_in < +1/4*pi);
    theta_delta_conditioned{2} = theta_delta(theta_in > +1/4*pi & theta_in < +3/4*pi);
    theta_delta_conditioned{3} = theta_delta(theta_in > +1/4*pi | theta_in < -1/4*pi);
    theta_delta_conditioned{4} = theta_delta(theta_in > -3/4*pi & theta_in < -1/4*pi);
elseif contains(eset_info,"ortho") || contains(eset_info,"ctl")
    theta_delta_conditioned{1} = theta_delta(theta_in > 0 & theta_in < 1/2*pi);
    theta_delta_conditioned{2} = theta_delta(theta_in > 1/2*pi & theta_in < pi);
    theta_delta_conditioned{3} = theta_delta(theta_in > -pi & theta_in < -1/2*pi);
    theta_delta_conditioned{4} = theta_delta(theta_in > -1/2*pi & theta_in < 0);
end

end