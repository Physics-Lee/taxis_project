function plot_C_t_Separating_f_r(t,C,label)

% Find the indices where the label changes
changeIndices = find(diff(label) ~= 0) + 1;

% Add the start and end indices to the list for complete segmentation
segIndices = [1, changeIndices, length(label) + 1];

% Plot each segment
figure;
hold on;
for i = 1:length(segIndices)-1
    % Extract the current segment
    t_seg = t(segIndices(i):segIndices(i+1)-1);
    C_seg = C(segIndices(i):segIndices(i+1)-1);
    label_seg = label(segIndices(i)); % The label for this segment
    
    % Determine the color based on the label
    color = 'r'; % Default to red
    if label_seg == 1
        color = 'b'; % Change to blue if label is 1
    end
    
    % Plot the segment
    plot(t_seg, C_seg, [color '-']);
end

% Customize the plot
xlabel("t (s)");
ylabel("C (mM)");

end