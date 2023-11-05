function p_value = Chi_2_test(count_0_1,count_0_0,count_0)

    chi_2_value = (count_0_1-count_0*0.5)^2/(count_0*0.5)...
        + (count_0_0-count_0*0.5)^2/(count_0*0.5);
    p_value = chi2cdf(chi_2_value,1,'upper');
    
end