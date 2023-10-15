% add legends base on partitioning region
%
% 2023-09-27, Yixuan Li
%

function add_legend(option_partition_region)

switch option_partition_region
    case "-3/4*pi_as_ideal"
        legend('[-\pi, -\pi/2]','[-\pi/2, 0]','[0, 1/2\pi]','[1/2\pi, \pi]', 'FontSize', 12, 'location', 'best');
    case "-pi_as_ideal"
        legend('[-5/4\pi, -3/4\pi]','[-3/4\pi, -1/4\pi]','[-1/4\pi, +1/4\pi]','[+1/4\pi, +3/4\pi]', 'FontSize', 12, 'location', 'best');
    case "-1/2*pi_as_ideal"
        legend('[-3/4\pi, -1/4\pi]','[-1/4\pi, +1/4\pi]','[+1/4\pi, +3/4\pi]','[+3/4\pi, +5/4\pi]', 'FontSize', 12, 'location', 'best');
end

end