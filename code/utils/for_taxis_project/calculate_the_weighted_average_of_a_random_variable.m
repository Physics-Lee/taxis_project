% calculate the weighted average of a random variable
% 
% input: n*1 x and n*1 weight
%
% output: 1*1 weighted_average
%
% 2023-10-25, Yixuan Li
%

function weighted_average = calculate_the_weighted_average_of_a_random_variable(x,weight)
weighted_average = sum(x.*weight)/sum(weight);
end