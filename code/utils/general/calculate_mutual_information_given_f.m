% calculate the mutual info of 2 distribution.
%
% f_joint, f_1, f_2 all need to be probability, not count or pdf
%
% Yixuan Li, 2023-12-01
%

function I = calculate_mutual_information_given_f(f_joint, f_1, f_2)

% Initialize mutual information
I = 0;

% Calculate mutual information
for i = 1:size(f_joint, 1)
    for j = 1:size(f_joint, 2)
        if f_joint(i, j) ~= 0 && f_1(i) ~= 0 && f_2(j) ~= 0
            I = I + f_joint(i, j) * log2(f_joint(i, j) / (f_1(i) * f_2(j)));
        end
    end
end

end