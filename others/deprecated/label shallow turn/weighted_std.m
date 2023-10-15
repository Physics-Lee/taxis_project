function result = weighted_std(data,frame_window)
% data should be 1*frame_window
% frame_window should be even
common_difference = 3; % super parameter
weight = 1:common_difference:frame_window/2*common_difference;
weight = [flip(weight) weight];
weight = weight/sum(weight);
result = sqrt(sum(weight.*(data - mean(data)).^2));
end