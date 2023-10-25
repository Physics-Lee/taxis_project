% add title
%
% 2023-09-27, Yixuan Li
%

function add_title(mat_name,~,~)

my_title = strrep(mat_name,'_',' ');
title(my_title, 'FontSize', 14);

% switch option_ideal_theta
%     case "-pi"
%         % ideal_unit_vector = [-1,0];
%         ideal_theta = -pi; % -pi and +pi have the same effect in function my_diff_v2
%     case "-3/4*pi"
%         % ideal_unit_vector = [-1,-1]/sqrt(2);
%         ideal_theta = -3/4*pi;
%     case "-1/2*pi"
%         % ideal_unit_vector = [0,-1];
%         ideal_theta = -1/2*pi;
% end
% 
% switch option_measure
% 
%     case "cos_to_ideal"
% 
%         my_title = [my_title '; ideal direction ' num2str(ideal_theta/pi*180)];
% 
%     case "MSE_to_ideal"
% 
%         my_title = [my_title '; ideal direction ' num2str(ideal_theta/pi*180)];
% 
% end
% 
% title(my_title, 'FontSize', 14);

end