for ii = 1:length(esets_results)    
    x_1 = esets_results{ii,5};
    x_2 = esets_results{ii,6};
    Pearson_r = corrcoef(x_1,x_2);
    Pearson_r = Pearson_r(1,2);
    esets_results{ii,7} = Pearson_r;
    [h,p_value] = ttest2(x_1,x_2);
    esets_results{ii,8} = h;
    esets_results{ii,9} = p_value;
end