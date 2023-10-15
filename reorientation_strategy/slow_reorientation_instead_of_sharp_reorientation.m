% esets = read_all_eset;
esets_results = cell(size(esets));
esets_results(:,2) = esets(:,2);

for ii = 1:length(esets)
    
    eset = esets{ii,1}.eset;
    [theta_in,theta_out,~,~] = extract_theta(eset); % You can change here to first half, second half or whole.
    
    if ~isempty(strfind(esets{ii,2}, 'NC')) || ~isempty(strfind(esets{ii,2}, 'NT'))
        [esets_results{ii,3},esets_results{ii,4}] = label_reorientation_NC_NT(theta_in,theta_out);
    end

    if strfind(esets{ii,2}, 'ortho')
        [esets_results{ii,3},esets_results{ii,4}] = label_reorientation_ortho(theta_in,theta_out);
    end
    
end