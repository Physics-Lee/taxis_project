function weighted_average = calculate_weighted_average_v2(x,weight)
% x is n*1 and weight is n*1
weighted_average = sum(x.*weight)/sum(weight);
end